Return-Path: <linux-kernel+bounces-170042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9818BD10C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8051F21FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630315445D;
	Mon,  6 May 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFFFMoVQ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7F15359F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008063; cv=none; b=YT9a3aIOHTZhD10bUHNgJo9WYc5QRKlVryJ+5j9WAZAFmua8tTNjirbmMYyth7ndtlMgtb60ofXIdKye73CDkTGXDWY4zKAG3AdjZjCSfZ+d+qifp8cvQJMvyHws8qoa12Wbmif5XWbhm9BhAzs/6auN7nrRymTaRxjaHP01NJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008063; c=relaxed/simple;
	bh=yqB1rDVuz8T2QPiRcNKDl9cE10YW/62Ppf6xQrl0dE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njyDEITGogE/rJ1s6xcTGLOIN/xlgp7CMmP1670grZWvkUs3DN19qqXrqx2mthY4gLV348PRMfiD/X8/QWuPwY0abwJxnzqecdoxrC57TeUwfatEzXyvFa5W2wI7+9DNZy68dcCm/Hc6Bw1aGg5OilPvZ6JgnaBplvkwY9QBGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFFFMoVQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-61be599ab77so645200a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715008061; x=1715612861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neQGyNV+29mTtk8Q8Cqua5MUdaby9aEM9B8FtgLuJf8=;
        b=gFFFMoVQTikQ/CdZ4+SOS4cHeepWq3qgokXaadQ9oPKeGswiap64Ndr/K7EibDpend
         HQiavUztKuO01rhZ6rve3EsaQ8iRtB3UH81fBsDXnoHvadfXHkwkdp0HoDyeigl9zcPP
         EB2T1q6HBLcmP1G8YFBVDSloBUyA3jtQslHPRBdZoDT04lJKBWue4s6551uErhXLVOJL
         OHy5FpSqVpwO6A4N83kS2JyAolkw2613QkMdeAviwVEOvKSI7YpQaynF1prAfYmlWVnL
         2gAci8H3Fzux6Zv7BtwQUccMn9EiIr9ulU7OxsurnPc37DT3WR0o9ntozEf8n7671KhJ
         n+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715008061; x=1715612861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neQGyNV+29mTtk8Q8Cqua5MUdaby9aEM9B8FtgLuJf8=;
        b=tVrKUrzCDbtlBrzmltujC9t7VpQn2bNfgXDKtEAqGK4LqrP9gUIAh9NvsxOFdbpsI5
         s5uB0/HUkSKP+T1Qg+wTh6bBhFFDjRQuXbrtBnxvFpiWKDHiozuNL2fBd6Q7eDWDN/Z4
         4WG1sczjX1i+0k1CrzDcTIJhFShwOLr4jpgVi3xGHEYmJaTwTkvag+7VqdRY8hb6m4T4
         pNtw+EJ/4Ivzq5AFFbdNWjbbvTTd7d2sv5j5iLGZMZH5wDOcDqcLJ92A9DvEyeioRIHt
         exhrKX+mZdqbcjtn9MymOQvWXdnJ5O/UREfV7fDR/eYpRCoNkliemUMPFwBlBvM3PPju
         nXGw==
X-Forwarded-Encrypted: i=1; AJvYcCVpNQB1sB0rMae/GMlAkhdZWfQnOXBj6FRNgMfpko1tAfZsSciylk28lDyVMJc3iSAdhbnYShmOSQihZSYfOI5Uw/w55LymLE1OPCwU
X-Gm-Message-State: AOJu0YwaC4snLd13J6WPlanD08IMNL2m6Ho9tga9D/4gEfIIwlp+WEhh
	kP0rED35HWVpXbRpNCjvU6pQD6o24by3VoGZ/uswlOWmV+A8xDb8ZKlJ+EtFfHQnB8oOAyPYAbG
	5p6MYf0Zx/UP5lZugBAzRysDMPsokWJl2
X-Google-Smtp-Source: AGHT+IGcvtTriyl/vepdivHRpRJovjDp8Qk11rQQEHS4UyhwdiwsUFxePf3tymHKBuNBmQkAym4sctAcIphE9xIRtWE=
X-Received: by 2002:a17:90b:11d4:b0:2b2:7c53:2601 with SMTP id
 gv20-20020a17090b11d400b002b27c532601mr8035017pjb.37.1715008061006; Mon, 06
 May 2024 08:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1237381714935562@dmcmxrwo3x2o7y3i.sas.yp-c.yandex.net> <20240505224508.GAZjgL9PO9Y5QaAO2t@fat_crate.local>
In-Reply-To: <20240505224508.GAZjgL9PO9Y5QaAO2t@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 May 2024 11:07:29 -0400
Message-ID: <CADnq5_NNATnV+mTEn6Mshro3gqpH5ffjQ=EWdH8QVZgEBYB-ew@mail.gmail.com>
Subject: Re: Error in amd driver?
To: Borislav Petkov <bp@alien8.de>
Cc: Tranton Baddy <t.baddy@yandex.ru>, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 6:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> + amd-gfx@lists.freedesktop.org
>
> On Sun, May 05, 2024 at 09:59:22PM +0300, Tranton Baddy wrote:
> > I have this in my dmesg since version 6.8.6, not sure when it appeared.=
 Is amdgpu driver has bug?

Should be fixed in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd3a9331a6591e9df64791e076f6591f440af51c3

Alex

> > [   64.253144] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   64.253162] BUG: KFENCE: use-after-free read in amdgpu_bo_move+0x51f=
/0x7a0
> >
> > [   64.253183] Use-after-free read at 0x00000000671c48dd (in kfence-#11=
1):
> > [   64.253192]  amdgpu_bo_move+0x51f/0x7a0
> > [   64.253202]  ttm_bo_handle_move_mem+0xcf/0x180
> > [   64.253211]  ttm_mem_evict_first+0x1c5/0x500
> > [   64.253218]  ttm_resource_manager_evict_all+0xa3/0x1e0
> > [   64.253228]  amdgpu_device_prepare+0x66/0x110
> > [   64.253237]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> > [   64.253248]  pci_pm_runtime_suspend+0x74/0x200
> > [   64.253259]  vga_switcheroo_runtime_suspend+0x21/0xb0
> > [   64.253268]  __rpm_callback+0x5f/0x190
> > [   64.253277]  rpm_callback+0x7f/0x90
> > [   64.253283]  rpm_suspend+0x120/0x6a0
> > [   64.253290]  pm_runtime_work+0x9c/0xa0
> > [   64.253297]  process_one_work+0x164/0x330
> > [   64.253310]  worker_thread+0x302/0x430
> > [   64.253320]  kthread+0xe4/0x110
> > [   64.253329]  ret_from_fork+0x4c/0x60
> > [   64.253341]  ret_from_fork_asm+0x1b/0x30
> >
> > [   64.253353] kfence-#111: 0x00000000d018cf03-0x0000000034e821d1, size=
=3D96, cache=3Dkmalloc-96
> >
> > [   64.253363] allocated by task 152 on cpu 3 at 64.248952s:
> > [   64.253418]  kmalloc_trace+0x283/0x340
> > [   64.253427]  amdgpu_vram_mgr_new+0x8f/0x3f0
> > [   64.253435]  ttm_resource_alloc+0x39/0x90
> > [   64.253444]  ttm_bo_mem_space+0xa4/0x260
> > [   64.253450]  ttm_mem_evict_first+0x18a/0x500
> > [   64.253456]  ttm_resource_manager_evict_all+0xa3/0x1e0
> > [   64.253465]  amdgpu_device_prepare+0x66/0x110
> > [   64.253472]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> > [   64.253481]  pci_pm_runtime_suspend+0x74/0x200
> > [   64.253489]  vga_switcheroo_runtime_suspend+0x21/0xb0
> > [   64.253496]  __rpm_callback+0x5f/0x190
> > [   64.253503]  rpm_callback+0x7f/0x90
> > [   64.253509]  rpm_suspend+0x120/0x6a0
> > [   64.253516]  pm_runtime_work+0x9c/0xa0
> > [   64.253523]  process_one_work+0x164/0x330
> > [   64.253532]  worker_thread+0x302/0x430
> > [   64.253542]  kthread+0xe4/0x110
> > [   64.253550]  ret_from_fork+0x4c/0x60
> > [   64.253559]  ret_from_fork_asm+0x1b/0x30
> >
> > [   64.253570] freed by task 152 on cpu 3 at 64.253117s:
> > [   64.253582]  ttm_resource_free+0x67/0x90
> > [   64.253591]  ttm_bo_move_accel_cleanup+0x247/0x2e0
> > [   64.253598]  amdgpu_bo_move+0x1bd/0x7a0
> > [   64.253605]  ttm_bo_handle_move_mem+0xcf/0x180
> > [   64.253612]  ttm_mem_evict_first+0x1c5/0x500
> > [   64.253618]  ttm_resource_manager_evict_all+0xa3/0x1e0
> > [   64.253626]  amdgpu_device_prepare+0x66/0x110
> > [   64.253634]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
> > [   64.253642]  pci_pm_runtime_suspend+0x74/0x200
> > [   64.253650]  vga_switcheroo_runtime_suspend+0x21/0xb0
> > [   64.253658]  __rpm_callback+0x5f/0x190
> > [   64.253664]  rpm_callback+0x7f/0x90
> > [   64.253671]  rpm_suspend+0x120/0x6a0
> > [   64.253677]  pm_runtime_work+0x9c/0xa0
> > [   64.253684]  process_one_work+0x164/0x330
> > [   64.253693]  worker_thread+0x302/0x430
> > [   64.253703]  kthread+0xe4/0x110
> > [   64.253711]  ret_from_fork+0x4c/0x60
> > [   64.253723]  ret_from_fork_asm+0x1b/0x30
> >
> > [   64.253735] CPU: 3 PID: 152 Comm: kworker/3:2 Tainted: P           O=
E      6.8.9 #3 e7323d0d25f89e853881fc823e59523bdcc577c6
> > [   64.253756] Hardware name: Hewlett-Packard HP Pavilion Notebook /80B=
9, BIOS F.54 05/27/2019
> > [   64.253761] Workqueue: pm pm_runtime_work
> > [   64.253771] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

