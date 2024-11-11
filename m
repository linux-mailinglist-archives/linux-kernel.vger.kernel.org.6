Return-Path: <linux-kernel+bounces-404754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245499C47B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CB51F21CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E570A1F7576;
	Mon, 11 Nov 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eZn6Py1d"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B61BBBDA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358533; cv=none; b=TXdfIfyQhYxTB3EsRvB5nqk+xh5nMsupamgeTXM51ttgMhfma9ELBvAOuLFxhWRleTPFrcgLY4vOOnphba6pOwOo+PpAJY9p8DvE/EgNlukKWwZ6FcVrwdsmYAT/DA8woFKP2JOpKj9UmE80I7QhERMrScZtHm0FNVIXv2i7myM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358533; c=relaxed/simple;
	bh=LgM4AE7Tzv9AeqRy7Q+sooaI9o29H4tTVyGDKuUHyHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIy9JXGO6xd36uOW8SYB30A9X+qpUI8i6erFSdPcwCV9LR40VcFcI43bbZ28OEeAj1GKAekj3G1VjVtzLB2wkN5W7I93F4k8MxdT9bKiaO1Cnh0FeZjW3AAygoZi26dMIITihN8Pi3ChG/u/u1YG7JtnBjJ5N9RqC8JLT9W0BH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eZn6Py1d; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so762266366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731358528; x=1731963328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PzwaJfpjCWLO4jufnqOHdSuICRaS5WL/Td3je3MgZo=;
        b=eZn6Py1dfumgs1cm6dhEDE1YmLGi3J74BijEyhzL8aDGHwnAclF7mOsMXgUog28FuH
         ZI8X/Z6w/HKJxtsRVXdTJAJOciZlVF0JxYneHt4YQX/uHtL+85wbFv4x+PfsdwhowN+w
         yl+UTGGsugdjwNq0G+d7jXtSbgFldcX2bdfVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358528; x=1731963328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PzwaJfpjCWLO4jufnqOHdSuICRaS5WL/Td3je3MgZo=;
        b=lgp/h5A6gzc5OZsEMDJtokRu9PrtgxviNpmol03zlqKpagjpYEqTx+H+8FqbRq36w5
         Bl+z0M+jLeJPuaEwwf/5BACYg2C+PTwB0sKYnaFTv7LLgAc0JD17v1SYzrBceeETfJ3n
         pf23YYjyCBDHH9D1ZfIGpEQyboitzDPTsGRltblzQ5CHAFJ/ShNss7i8LVo2vgUdLv8j
         wn9wEXN9BGcFKt/xrLdJYDxu7aXliv6oTENjSogrLKlkGYWclVLyLl9zWbr9hq3NZvhW
         1lk8pH4dxMoGlUnMMhjPejeIgLAmKkkAH+MW0AinLKQaqz5jjYB2CVmm2AbCZCPDRzox
         jRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlZ//fEQGB5PppXdFbNNXa7ttrNbg1MBGBxcbbSD6oOEp/vW2Rxo8xNkW4VSqxfyQjp2HS32egaKfqPis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlWzXonhTMm/vcp/T/pyUtu6Qr1K0ysaocuLGAblt6OMTe7A3
	JEzxn4xGRvehMlZacDrajlAESuklY71Uz7pg9jK7yovxD+NtxGPBKDSTBR9CnX8BzI+eueZ9vgC
	Y3jnO0s60+r46okuRSoY6c185+r/Xit8xvLVm317T7JNEqsbwtyOqVnWzEFnU9gRd1nfysg82Yt
	GigyLgrzPsoxJIB/K+C9SzaNWiAw==
X-Google-Smtp-Source: AGHT+IHtHJN2wlO/dS5Ho/xwNaDeL38A3oTas8GP+XhFN9vBlIEyqtN762oFpzrjya5bJyQoWb9F5Nm6P8AF1PfXcNY=
X-Received: by 2002:a17:907:2cc7:b0:a9e:6e77:3ecd with SMTP id
 a640c23a62f3a-a9ef00191a8mr1012446866b.54.1731358527999; Mon, 11 Nov 2024
 12:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com> <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
 <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com> <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com> <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
 <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com>
In-Reply-To: <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com>
From: Doug Covelli <doug.covelli@broadcom.com>
Date: Mon, 11 Nov 2024 15:55:17 -0500
Message-ID: <CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:49=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 11/9/24 22:11, Doug Covelli wrote:
> > On Sat, Nov 9, 2024 at 1:20=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >> On 11/8/24 06:03, Zack Rusin wrote:
> >>>>> There's no spec but we have open headers listing the hypercalls.
> >>>>> There's about a 100 of them (a few were deprecated), the full
> >>>>> list starts here:
> >>>>> https://github.com/vmware/open-vm-tools/blob/739c5a2f4bfd4cdda491e6=
a6f6869d88c0bd6972/open-vm-tools/lib/include/backdoor_def.h#L97
> >>>>> They're not well documented, but the names are pretty self-explenat=
ory.
> >>>>
> >>>> At a quick glance, this one needs to be handled in KVM:
> >>>>
> >>>>     BDOOR_CMD_VCPU_MMIO_HONORS_PAT
> >>>>
> >>>> and these probably should be in KVM:
> >>>>
> >>>>     BDOOR_CMD_GETTIME
> >>>>     BDOOR_CMD_SIDT
> >>>>     BDOOR_CMD_SGDT
> >>>>     BDOOR_CMD_SLDT_STR
> >>>>     BDOOR_CMD_GETTIMEFULL
> >>>>     BDOOR_CMD_VCPU_LEGACY_X2APIC_OK
> >>>>     BDOOR_CMD_STEALCLOCK
> >>>
> >>> I'm not sure if there's any value in implementing a few of them.
> >>
> >> The value is that some of these depend on what the hypervisor does, no=
t
> >> on what userspace does.  For Hypervisor.framework you have a lot of
> >> leeway, for KVM and Hyper-V less so. [..] From the KVM maintainers'
> >> point of view, the feature you're adding might be used by others and
> >> not just VMware Workstation.  Microsoft and Apple might see things
> >> differently (Apple in particular has a much thinner wrapper around
> >> the processor's virtualization capbilities).
> >
> > [...]
> >
> > the SGDT/SLDT/STR/SIDT backdoor calls these were added > 20
> > years ago for SW that used these instructions from CPL3 which did not
> > work well before VT/SVM were introduced.  These are really of no use
> > on modern CPUs and will be blocked if the guest OS has enabled UMIP.
> > [...]
> >
> > For stolen time the backdoor call is [...] currently
> > really only supported by ESX (and only currently used by Photon OS) so
> > I don't think adding that support to KVM is critical.
>
> Sounds good.  All I want is ensuring that someone with access to the
> spec did the exercise.
>
> Still guessing, but for MMIO_HONORS_PAT we probably want to add a
> separate KVM_CHECK_EXTENSION capability.
>
> Is BDOOR_CMD_VCPU_LEGACY_X2APIC_OK something where you can just return a
> constant?
>
> This leaves just GETTIME and GETTIMEFULL.  If four hypercalls require
> some care in the hypervisor (which may or may not be an in-kernel
> implementation), that's not bad.  Can you share a bit more about these fo=
ur?

BDOOR_CMD_VCPU_MMIO_HONORS_PAT and BDOOR_CMD_VCPU_LEGACY_X2APIC_OK are not
actually backdoor calls - they are flags returned by BDOOR_CMD_GET_VCPU_INF=
O.

BDOOR_CMD_VCPU_MMIO_HONORS_PAT is only ever set to 1 on ESX as it is only
relevant for PCI passthru which is not supported on Linux/Windows/macOS.  I=
IRC
this was added over 10 years ago for some Infiniband device vendor to use i=
n
their driver although I'm not sure that ever materialized.

BDOOR_CMD_VCPU_LEGACY_X2APIC_OK indicates if it is OK to use x2APIC w/o
interrupt remapping (e.g a virtual IOMMU).  I'm not sure if KVM supports th=
is
but I think this one can be set to TRUE unconditionally as we have no plans=
 to
use KVM_CREATE_IRQCHIP - if anything we would use KVM_CAP_SPLIT_IRQCHIP alt=
hough
my preference would be to handle all APIC/IOAPIC/PIC emulation ourselves
provided we can avoid CR8 exits but that is another discussion.

For now I think it makes sense to handle BDOOR_CMD_GET_VCPU_INFO at userlev=
el
like we do on Windows and macOS.

BDOOR_CMD_GETTIME/BDOOR_CMD_GETTIMEFULL are similar with the former being
deprecated in favor of the latter.  Both do essentially the same thing whic=
h is
to return the host OS's time - on Linux this is obtained via gettimeofday. =
 I
believe this is mainly used by tools to fix up the VM's time when resuming =
from
suspend.  I think it is fine to continue handling these at userlevel.

Doug

> >> Anyway, one question apart from this: is the API the same for the I/O
> >> port and hypercall backdoors?
> >
> > Yeah the calls and arguments are the same.  The hypercall based
> > interface is an attempt to modernize the backdoor since as you pointed
> > out the I/O based interface is kind of hacky as it bypasses the normal
> > checks for an I/O port access at CPL3.  It would be nice to get rid of
> > it but unfortunately I don't think that will happen in the foreseeable
> > future as there are a lot of existing VMs out there with older SW that
> > still uses this interface.
>
> Yeah, but I think it still justifies that the KVM_ENABLE_CAP API can
> enable the hypercall but not the I/O port.
>
> Paolo
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

