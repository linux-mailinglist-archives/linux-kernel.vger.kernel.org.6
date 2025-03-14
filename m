Return-Path: <linux-kernel+bounces-561163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6998A60E34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B617AAC1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF21F4161;
	Fri, 14 Mar 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzTy0ovi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE81EF09A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946758; cv=none; b=FuD3C422YDI4Q7qIEYZQdYO3MW4y2XE8BEnaRcMy6ke8c55Gj5+skQFZQyEzjea2/DIFNjxEX/Ls/c/Znr03b9fuZE0yYCvT3s5wxPFO5Of+6wo6rhg4knuStU63VmcXXsnHpyjtYz92ez4ga+q6wYEN1QpsjtKfPCaKVmFB0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946758; c=relaxed/simple;
	bh=qGfUz2A6+bP42Oib+saXWyXlLN8ysp2BmgZjQfwbSHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHPamoAe5OIDj8erZclA0ArCxJL64r45bbE8azcJA3uZFfogYCaAz/FzuiGA8mKm5SZUlS5zU+lUcC3DojNlpOYQI9nkagkWfRnGGeXYoR76LYcCqC+IohMqjcWjYlJWikhfBSl88uMuyhkkR6A+TIY74JP121+by0hwY8HeFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzTy0ovi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741946754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SjL8H+4/T2Oa3O4IXcLJzoxoe5HpoBiyEUa4YYA3vQ=;
	b=TzTy0ovilkxKSJ4TBlUKw/RD3GwMpcgxmiei+Ilp3CYggBrpX6XgSGJewceAZsvIPD/2no
	huyZ6DLi1vvVzzP0AhVAg8n4REXdmI/QKckN6gFi4bHklsQFpfI1CcnY1DbaBHjFTxTU3I
	X4bf2WJgUBq+M8hd58dc0nsa0ieCsi8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-ELsdrY6CMYa4VPlsEOoqpA-1; Fri, 14 Mar 2025 06:05:53 -0400
X-MC-Unique: ELsdrY6CMYa4VPlsEOoqpA-1
X-Mimecast-MFC-AGG-ID: ELsdrY6CMYa4VPlsEOoqpA_1741946752
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54995da5b1bso1041823e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946746; x=1742551546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SjL8H+4/T2Oa3O4IXcLJzoxoe5HpoBiyEUa4YYA3vQ=;
        b=T52iQ3vGKVj3CvCan5Jxqa4Kk9za4LlaI9F1Bw0dFCFGeeqDNq3U6bV4N9sm0Tvzhk
         YPwgJgR3NftylAsvDzVElgalqlr6gBxxKtvojIUWPca8n2Og2nrpGwnLs2HHMqQV4OUg
         rXBpKeOo3IcznchlNTVoYxonDxPrPDIE0i1EkIl9VuaRYNYY7J08ffj3CBLSmthvjwI4
         DzAXD/UghOkVbhfKxhZbKpp98jKmBG+mHfsKxXrlRxvmNWZCmcJWoeNy5ODz0JijkVYA
         QxxPjq9fNuhXqzJksthpzDFMods6bzu0DzC3T4ckKLwoIcOny5+Oe7kSefKY5lNerBk3
         mjig==
X-Forwarded-Encrypted: i=1; AJvYcCVYsy6Q5h25JkJZLToyLOt590aGGv3UfwLicWUTGlRWFInb6OeDXvWuZtSn2+Y47CS47OqT3uNq6fxykuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHEOfs6XXHBPKBr5Wq6D/7u6suMrIQ8yXFNFU/62j0nbXpP2D
	JssWztKtqqaVPQoJViMFh0ek5+Vyf91PQrMvKRxPhmexAmnAQtNIrm2CoFolnh6oGXYuvWSByJs
	eAeDtXxmdduu+/Hewd7K0FuYQ6idTulKY3scrSbFUWE2OBEcpUDtVGUMcGzS3ADuWQ6ZvMg==
X-Gm-Gg: ASbGncsp9nEXlO1y0/O+0KHWp6HZFfIinPVwMWzBXu/QimAoL3520vatGyALJlv4Roa
	/SXR3QNcHWwwDjJXUK217c/QlVEcH2Qkmr0HMvVx9bbC8rNobhVsJiO7d3VNiNgrlgdu3KOfkPd
	cDn4yUWIArvoGj8hF8Xb4/jwTQnCr0xC/21btzdQZ9sl9Szdl+0gn+444DwtbRtNF3K3LVB+Td6
	FxETNkduZjCXjENaHlDra/SfLSIIcpOB3PbNvwcUjG1SWfvIsovStvfXwabmHtdR3g5JgiXyM7Z
	+kCw5Dn1BmIFqEwwPs4ryO8YrP+CUzJHIiTlIqmoAgo=
X-Received: by 2002:a05:6512:1109:b0:549:90ac:cca2 with SMTP id 2adb3069b0e04-549c3ef8526mr667961e87.1.1741946746491;
        Fri, 14 Mar 2025 03:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiUG5mufOPbPyGpa4upZZ2xUrM3yd1XL5hmbioxq8dkPC2ew7wTJjBZeeb99vi9i/pwMh7sw==
X-Received: by 2002:a05:600c:44d2:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-43d180d03dfmr57502085e9.15.1741946734434;
        Fri, 14 Mar 2025 03:05:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad64sm12058185e9.25.2025.03.14.03.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:05:33 -0700 (PDT)
Date: Fri, 14 Mar 2025 11:05:31 +0100
From: "juri.lelli@redhat.com" <juri.lelli@redhat.com>
To: "Ma, Jiping" <Jiping.Ma2@windriver.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"wander@redhat.com" <wander@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jiping.ma2@windirvier.com" <jiping.ma2@windirvier.com>,
	"Tao, Yue" <Yue.Tao@windriver.com>
Subject: Re: sched/deadline:  warning in migrate_enable for boosted tasks
Message-ID: <Z9P_a9y_2aqJH2xy@jlelli-thinkpadt14gen4.remote.csb>
References: <IA1PR11MB6489427BF9BCE1809FA4D1EED8D22@IA1PR11MB6489.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR11MB6489427BF9BCE1809FA4D1EED8D22@IA1PR11MB6489.namprd11.prod.outlook.com>

Hello,

On 14/03/25 04:02, Ma, Jiping wrote:
> Hi, All
>=20
> We encounter this kernel warning,  it looks similar with the one you
> are discussing [PATCH 6.6 331/356] sched/deadline: Fix warning in
> migrate_enable for boosted tasks - Greg
> Kroah-Hartman<https://lore.kernel.org/all/20241212144257.639344223@linuxf=
oundation.org/>.
> Do you have any idea for the issue?
>=20
> kernel: warning [  998.494702] WARNING: CPU: 19 PID: 217 at kernel/sched/=
deadline.c:277 dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494705] Modules linked in: iptable_nat ceph netfs =
macvlan igb_uio(O) uio nbd rbd libceph dns_resolver nf_conntrack_netlink nf=
netlink_queue xt_NFQUEUE xt_set xt_multiport ipt_rpfilter ip6t_rpfilter ip_=
set_hash_net ip_set_hash_ip ip_set veth wireguard libchacha20poly1305 chach=
a_x86_64 poly1305_x86_64 curve25519_x86_64 libcurve25519_generic libchacha =
xt_nat xt_MASQUERADE xt_mark ipt_REJECT nf_reject_ipv4 nft_chain_nat nf_nat=
 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_comment vfio_pc=
i vfio_pci_core binfmt_misc iscsi_target_mod target_core_mod drbd dm_crypt =
trusted asn1_encoder xt_addrtype nft_compat nf_tables nfnetlink br_netfilte=
r bridge virtio_net net_failover failover nfsd auth_rpcgss nfs_acl lockd gr=
ace overlay 8021q garp stp mrp llc xfs vfio_iommu_type1 vfio sctp ip6_udp_t=
unnel udp_tunnel xprtrdma(O) svcrdma(O) rpcrdma(O) nvmet_rdma(O) nvme_rdma(=
O) ib_srp(O) ib_isert(O) ib_iser(O) rdma_rxe(O) mlx5_ib(O) mlx5_core(O) mlx=
fw(O) mlxdevm(O) psample tls macsec rdma_ucm(O) rdma_cm(O) iw_cm(O)
> kernel: warning [  998.494748]  ib_uverbs(O) ib_ucm(O) ib_cm(O) lru_cache=
 libcrc32c fuse drm sunrpc efivarfs ip_tables ext4 mbcache jbd2 dm_multipat=
h dm_mod sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 iTCO_wdt=
 wmi_bmof iTCO_vendor_support dell_smbios dell_wmi_descriptor ledtrig_audio=
 rfkill video intel_uncore_frequency intel_uncore_frequency_common x86_pkg_=
temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pc=
lmul bnxt_re(O) crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 =
ib_core(O) rapl mlx_compat(O) uas intel_cstate intel_uncore acpi_ipmi mei_m=
e ahci i2c_i801 bnxt_en(O) usb_storage i2c_smbus intel_pch_thermal mei liba=
hci intel_vsec wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter ia=
vf(O) i40e(O) ice(O) [last unloaded: drbd]
> kernel: warning [  998.494781] CPU: 19 PID: 217 Comm: ktimers/19 Kdump: l=
oaded Tainted: G        W  O       6.6.0-1-rt-amd64 #1  Debian 6.6.52-1.stx=
=2E95
> kernel: warning [  998.494783] Hardware name: Dell Inc. PowerEdge XR11/0P=
2RNT, BIOS 1.15.2 09/10/2024
> kernel: warning [  998.494784] RIP: 0010:dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494786] Code: 48 c7 c7 e0 eb 89 ae c6 05 fd a2 6d =
01 01 e8 9b ac f9 ff 0f 0b eb 81 48 c7 c7 c5 39 83 ae c6 05 e7 a2 6d 01 01 =
e8 84 ac f9 ff <0f> 0b 48 8b 83 28 09 00 00 49 39 c5 0f 83 53 ff ff ff 48 c=
7 83 28
> kernel: warning [  998.494788] RSP: 0000:ff32fa3140adbca8 EFLAGS: 00010082
> kernel: warning [  998.494790] RAX: 0000000000000000 RBX: ff2ef1f93faf23c=
0 RCX: ff2ef1f93fae0608
> kernel: warning [  998.494791] RDX: 00000000ffffffd8 RSI: 000000000000002=
7 RDI: ff2ef1f93fae0600
> kernel: warning [  998.494793] RBP: ff2ef1e9c19eaf80 R08: 000000000000000=
0 R09: ff32fa3140adbc30
> kernel: warning [  998.494794] R10: 0000000000000001 R11: 000000000000001=
5 R12: 000000000000000e
> kernel: warning [  998.494795] R13: 0000000000000000 R14: 00000000fffffff=
f R15: 000000000000000e
> kernel: warning [  998.494796] FS:  0000000000000000(0000) GS:ff2ef1f93fa=
c0000(0000) knlGS:0000000000000000
> kernel: warning [  998.494798] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> kernel: warning [  998.494799] CR2: 00000000181b50a0 CR3: 000000063db6800=
5 CR4: 0000000000771ee0
> kernel: warning [  998.494801] DR0: 0000000000000000 DR1: 000000000000000=
0 DR2: 0000000000000000
> kernel: warning [  998.494802] DR3: 0000000000000000 DR6: 00000000fffe0ff=
0 DR7: 0000000000000400
> kernel: warning [  998.494803] PKRU: 55555554
> kernel: warning [  998.494804] Call Trace:
> kernel: warning [  998.494805]  <TASK>
> kernel: warning [  998.494805]  ? __warn+0x89/0x140
> kernel: warning [  998.494808]  ? dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494810]  ? report_bug+0x198/0x1b0
> kernel: warning [  998.494814]  ? handle_bug+0x3c/0x70
> kernel: warning [  998.494816]  ? exc_invalid_op+0x18/0x70
> kernel: warning [  998.494818]  ? asm_exc_invalid_op+0x1a/0x20
> kernel: warning [  998.494821]  ? dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494823]  ? dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494825]  rt_mutex_setprio+0x240/0x460
> kernel: warning [  998.494828]  rt_mutex_slowunlock+0x143/0x280
> kernel: warning [  998.494831]  ? __pfx_mce_timer_fn+0x10/0x10
> kernel: warning [  998.494833]  mce_timer_fn+0x90/0xe0
> kernel: warning [  998.494835]  ? __pfx_mce_timer_fn+0x10/0x10
> kernel: warning [  998.494837]  call_timer_fn+0x24/0x130
> kernel: warning [  998.494840]  expire_timers+0xd3/0x1c0

Not sure it's the same issue. Stacktrace looks different. Anyway, are
you maybe able to verify if the issue is still reproducible with latest
v6.6-rt stable (v6.6.78-rt51 at the time of writing)?

Looks like you are on v6.6-rt, thus the question.

Thanks,
Juri


