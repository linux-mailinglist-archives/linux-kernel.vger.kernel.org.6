Return-Path: <linux-kernel+bounces-447576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5129F3464
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8461B18883A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C0146A60;
	Mon, 16 Dec 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id+CL++u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F00145A16
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362608; cv=none; b=M3mmtphC4shWfs1J+n3JkTLVSlE0jNPtZHEytq3I/IksTN/EPaf4be1XMnZdCP5BIlEgyzUG5LdHCLq3th8N2DS0oWDT0XuzPlI/UMo6sVEA1pXKgzJXtocNL19Ruf4CS+Sz+KHiLW1XvpySp8/TSvigAj08LsOgHH1vyqiLmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362608; c=relaxed/simple;
	bh=QtQQsUiJel4bUfPgyvGeB68f8I6g4jzU2Xy/nrs5h8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk26mtl21WlGTrXQOhgYmsEiJrxWVCkNgg27k4DMobz8IZU/DRfLH2gEjWbflNfAWU8GwQU3l5o+4USSHM23Iqr9aZS1kfSQr1EfOLKhJQF1gjTJEiNDAfiLySjK8lU6aZoLnrjcvfsea5Jl8eBG1+BsPJrtwUuHOVmOkS2EO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=id+CL++u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734362606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22hfpCiAB76G1lhRVgQIdpwqzCYya1oQySaYuhV9NKI=;
	b=id+CL++uo4rd+DTZq/YmaLWz8SsKByr4z4QkXPt37wm8XPhEK4NHwxZxtumD8u4qn0Ewjm
	hm47r/bPQgUrFk8+/YznJFJZrSO8xSLvc18iPzxitaprJZLmaSTuqJ5fVykEGavuCuQ7eF
	Z3q/K6Fa5KMjBFKZ+R5bBgmpOlzfsHE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-gj08dVGqOsuJi_B7aO_3EQ-1; Mon, 16 Dec 2024 10:23:23 -0500
X-MC-Unique: gj08dVGqOsuJi_B7aO_3EQ-1
X-Mimecast-MFC-AGG-ID: gj08dVGqOsuJi_B7aO_3EQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d89a389ee9so98594536d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734362603; x=1734967403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22hfpCiAB76G1lhRVgQIdpwqzCYya1oQySaYuhV9NKI=;
        b=nmbFmETmtvX+F5WKqURnhIXWzPbgL5nAxI+xSfyDeENVg9Wwj8sYT+cFoRHbm5yLZ5
         inYDD6bSj9p35FF8UV6Vuns28YTuAnlVk+GTi9nvGaGpnaEW/NmFLidQxNNywArdnCb1
         m7R9/DIPNkeceRpGVfvhT8JnRVTP1WyBOXIl51FC7lf5ORUpQt643tRqPqRTduraPURK
         wPl1xhIwKOy4zyeT2UNLrPFFeexbBUX3TDtgJk6dzNNu/LLPsG2A90vI4TlGsRVYowdx
         JGkyTarTreiOMyTIVsdLVxOttFkbzebk1P4fsGJVhRUx8JWeqklVhpH+Bo0XoKpdH6n9
         ji8g==
X-Forwarded-Encrypted: i=1; AJvYcCXab62HcsWAdC+92VJ82x8w4TzrcNiL34vwKdwuguifv5RAGuhaO3QgHlkd7QBE3b37O7INL1ZRCJ1NGHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeGI1/OtNjptZyu8u4Vojt/poLrBWz/yGZE00CyRqJ2iQeuR9
	Ba/8bc1KvLvu7Ct17EErtMAX5c5uSdKWCvy+aU0q9gF6bJafuaOvsuO//dMcmfUyuP6nN61ZyRU
	O1sft7WUJolmJoLZS3Kyuvr/Ukq3SVSsiOJMCEqduncJHMBjxqtIncjEuUW0B5w==
X-Gm-Gg: ASbGncuFOA7HXAgP0Rmc32NsvRH514BAKjwBPO8VXgeHj0rT4UWdowNqSiXIZiKBuNw
	Hh+TsQGJnpDQ/0RcpnnfAstnar6S6r0O2b/S3r6PplnUSJeD1pJyfe9m1OhpDJZxHijGbt85BQD
	vhQtbGYfPb98NJZ871I8MPEarb14qrYE2QRErNiz84pPRpUjIEn2pR8SupKpe/eUPYoGW7QSQhW
	UiEjPly3xjiuCqlPQ/4ZzDU8/RbE12tzRjcylNyXTy91PmUbZ+sG+/6Zcz6DQ4gleSlUwyLlyBf
	RV7ZI0JR6o7oFwljiMITz6vyfgoasMSNvPQ8E1CFeEo=
X-Received: by 2002:a05:6214:194e:b0:6d4:2646:109c with SMTP id 6a1803df08f44-6dc844afed0mr215332106d6.3.1734362602943;
        Mon, 16 Dec 2024 07:23:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7QXHgGXzgEjQZ3uTdpr42Buq+L+mX3JmSnr4maysHO6br7rvRW5Vl5hNJwPdDyY7Ey/ZXYQ==
X-Received: by 2002:a05:6214:194e:b0:6d4:2646:109c with SMTP id 6a1803df08f44-6dc844afed0mr215331766d6.3.1734362602600;
        Mon, 16 Dec 2024 07:23:22 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-197-226.as13285.net. [80.47.197.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd279544sm28346516d6.70.2024.12.16.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:23:22 -0800 (PST)
Date: Mon, 16 Dec 2024 15:23:18 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ranguvar <ranguvar@ranguvar.io>, Juri Lelli <juri.lelli@gmail.com>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "regressions@leemhuis.info" <regressions@leemhuis.info>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	juri.lelli@redhat.com
Subject: Re: [REGRESSION][BISECTED] from bd9bbc96e835: cannot boot Win11 KVM
 guest
Message-ID: <gvam6amt25mlvpxlpcra2caesdfpr5a75cba3e4n373tzqld3k@ciutribtvmjj>
References: <jGQc86Npv2BVcA61A7EPFQYcclIuxb07m-UqU0w22FA8_o3-0_xc6OQPp_CHDBZhId9acH4hyiOqki9w7Q0-WmuoVqsCoQfefaHNdfcV2ww=@ranguvar.io>
 <20241214185248.GE10560@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214185248.GE10560@noisy.programming.kicks-ass.net>

On 14/12/24 19:52, Peter Zijlstra wrote:
> On Sat, Dec 14, 2024 at 06:32:57AM +0000, Ranguvar wrote:
> > Hello, all,
> > 
> > Any assistance with proper format and process is appreciated as I am new to these lists.
> > After the commit bd9bbc96e835 "sched: Rework dl_server" I am no longer able to boot my Windows 11 23H2 guest using pinned/exclusive CPU cores and passing a PCIe graphics card.
> > This setup worked for me since at least 5.10, likely earlier, with minimal changes.
> > 
> > Most or all cores assigned to guest VM report 100% usage, and many tasks on the host hang indefinitely (10min+) until the guest is forcibly stopped.
> > This happens only once the Windows kernel begins loading - its spinner appears and freezes.
> > 
> > Still broken on 6.13-rc2, as well as 6.12.4 from Arch's repository.
> > When testing these, the failure is similar, but tasks on the host are slow to execute instead of stalling indefinitely, and hung tasks are not reported in dmesg. Only one guest core may show 100% utilization instead of many or all of them. This seems to be due to a separate regression which also impacts my usecase [0].
> > After patching it [1], I then find the same behavior as bd9bbc96e835, with hung tasks on host.
> > 
> > git bisect log: [2]
> > dmesg from 6.11.0-rc1-1-git-00057-gbd9bbc96e835, with decoded hung task backtraces: [3]
> > dmesg from arch 6.12.4: [4]
> > dmesg from arch 6.12.4 patched for svm.c regression, has hung tasks, backtraces could not be decoded: [5]
> > config for 6.11.0-rc1-1-git-00057-gbd9bbc96e835: [6]
> > config for arch 6.12.4: [7]
> > 
> > If it helps, my host uses an AMD Ryzen 5950X CPU with latest UEFI and AMD WX 5100 (Polaris, GCN 4.0) PCIe graphics.
> > I use libvirt 10.10 and qemu 9.1.2, and I am passing three PCIe devices each from dedicated IOMMU groups: NVIDIA RTX 3090 graphics, a Renesas uPD720201 USB controller, and a Samsung 970 EVO NVMe disk.
> > 
> > I have in kernel cmdline `iommu=pt isolcpus=1-7,17-23 rcu_nocbs=1-7,17-23 nohz_full=1-7,17-23`.
> > Removing iommu=pt does not produce a change, and dropping the core isolation freezes the host on VM startup.
> > Enabling/disabling kvm_amd.nested or kvm.enable_virt_at_load did not produce a change.
> > 
> > Thank you for your attention.
> > - Devin
> > 
> > #regzbot introduced: bd9bbc96e8356886971317f57994247ca491dbf1
> > 
> > [0]: https://lore.kernel.org/regressions/52914da7-a97b-45ad-86a0-affdf8266c61@mailbox.org/
> > [1]: https://lore.kernel.org/regressions/376c445a-9437-4bdd-9b67-e7ce786ae2c4@mailbox.org/
> > [2]: https://ranguvar.io/pub/paste/linux-6.12-vm-regression/bisect.log
> > [3]: https://ranguvar.io/pub/paste/linux-6.12-vm-regression/dmesg-6.11.0-rc1-1-git-00057-gbd9bbc96e835-decoded.log
> 
> Hmm, this has:
> 
> [  978.035637] sched: DL replenish lagged too much
> 
> Juri, have we seen that before?

Not in the context of dl_server. Hummm, looks like replenishment wasn't
able to catch up with the clock or something like that (e.g.
replenishment didn't happen for a long time).


