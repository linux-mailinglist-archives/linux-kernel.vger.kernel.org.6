Return-Path: <linux-kernel+bounces-290238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D6955123
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63C01F21D52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134A51C3F1C;
	Fri, 16 Aug 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ORS2B5Zq"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79701C0DC5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834593; cv=none; b=BCLlNM+88vl5hlRnE+VPXisU3vUx8Ky4MYAcJY5//d+rS+5vu30klQVaoErk2m30J+kzQQuGbeCQaqaC+RDX9vBlLYBSAgjikk25flQaoOJ1fclSIwcH0oznSvToqnotIFeh77FpXxG5HU+1OkC78MNuSjsYBdU6XvceKAsVEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834593; c=relaxed/simple;
	bh=omeU3vs4ZP4ku2x0A0zIzLPgOs2iEqHgbhD7/9yH5E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smERx6NwwzC108mZe7k7VKZ5QJDhpG2EzoM9b22OdjEUcLpHAhx1vbF50EFQSAAWRpanSwoxIfww3ahOetMBNua+FsAD3190jJPlhijpfvJ7w0NjvMWBH+It4RIYbM25/PY/Jwjh0B44COOjrclOD4m0GggmJOpgtHOi9xawy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ORS2B5Zq; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso2546576276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723834591; x=1724439391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+RwyLKvh3UIcOVfcaxSgjkMZTMy6zOQrBzrBolUKbQ=;
        b=ORS2B5ZqvtGIrW+sgXhPDV001al9ew2+2nR85IZVJWbn2yFVP5B7SqAKu/xMuD7eBW
         P7PNYO6wy+Zb2KrIGdlV4G82qAHZgN77aTnq3vna3oDwI/VuCHpbuEtw9rFEjOuQ1o/7
         syWezTwhFfnp4NLJfiVhP4OnMzjUGdXYHlVf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723834591; x=1724439391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+RwyLKvh3UIcOVfcaxSgjkMZTMy6zOQrBzrBolUKbQ=;
        b=oYR2chME4uQ1DOPsj7LNaCMuGoqkY5ciaVBt3Xe57Ht+VTzF8D0lNODC9rGloxvsaQ
         gSb01Bg+XoKYqIHK4WD6t7l5XnLVpwM600osjpkgGtsd+nnN4nC6e1Pjz3tI3/os8CzH
         QOGwE+J9gLoiGLck529yE9Voaf0BcVa+O6rHCpUAQyikycZd8oyTobZPGDCgi5H+Juq9
         RysA/WcdB4dhQ/bavoFrh2rpopPWPPg8hDitd5fKeOD1lh3yqkExmLBG7Dmko/AHlJDW
         KkDizvTyE4l9/6Ug2z1RIUpEJph2zCKX0t5sJYcFnvPNUKFgor1E917rGxc+TE2B9h/z
         6pwA==
X-Forwarded-Encrypted: i=1; AJvYcCW2uaBrL1JJJ45zgmpM5QMEKaP9ncRPQDaimj3iXrG/LkTkqTaCIPVoJ6yNX7u7UUwxqhBn4mUiWEMDx/OBcwQIQlkyZS3NOIVJBgha
X-Gm-Message-State: AOJu0Ywf4cRE3/g6cCQxzbZhow/p2s/zVQIXaluIoxtoztmoVwrUyjJs
	QXiygD5pG64In3xJI54i/cKWC08FxC32Z4zb/JMvNd5Psp99Ikm5lejfFV2NuOWI4ft9F8QigC5
	pk9STyKbcCncJxslrN4KIdInyG5AoGjRdzXU+
X-Google-Smtp-Source: AGHT+IEJ86OUuUV6ntheKjcJx7UnZj41T2D1bjC3vczY0XJSYxj6wSoCZ/gigl4V7uSZxjWkRVAEVYMjOlVRqfJGhXw=
X-Received: by 2002:a05:6902:1546:b0:e0b:ab65:19c8 with SMTP id
 3f1490d57ef6-e11810032c4mr4637525276.48.1723834590550; Fri, 16 Aug 2024
 11:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABQX2QM09V=+G=9T6Ax8Ad3F85hU0Cg4WqD82hTN=yhktXNDaQ@mail.gmail.com>
 <40cf01ab-73ad-4243-b851-a02c377bdbde@mailbox.org>
In-Reply-To: <40cf01ab-73ad-4243-b851-a02c377bdbde@mailbox.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 16 Aug 2024 14:56:19 -0400
Message-ID: <CABQX2QM1A9yWCuOHV6kgi3YbPvPHz-zazkOXM6Up9RWrZ-CgPQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] vmwgfx crashes with command buffer error
 after update
To: Andreas Piesk <a.piesk@mailbox.org>
Cc: bcm-kernel-feedback-list@broadcom.com, christian@heusel.eu, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	maaz.mombasawala@broadcom.com, martin.krastev@broadcom.com, rdkehn@gmail.com, 
	regressions@lists.linux.dev, spender@grsecurity.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:30=E2=80=AFPM Andreas Piesk <a.piesk@mailbox.org>=
 wrote:
>
> Hello,
>
> the bug was first reported on VMware Workstation by rdkehn.
>
> On my setup (archlinux text mode only VM on ESXi 8.0U3 latest) the kernel=
 does NOT crash, the screen just goes dark after switching the console from
>
> [    2.745694] Console: switching to colour dummy device 80x25
>
> to
>
> [    2.771998] Console: switching to colour frame buffer device 160x50
>
> You see the VMware remote console resizing, then going black and from thi=
s point no more output.
>
> I have attached boot_journal and vmware.log from my setup. VM uses EFI bo=
ot and SVGA with defaults as display adapter, I attached the vmx file too.

Thanks! I see. I have a patch out that fixes it, but in general I
think those vm's with 16mb for graphics are very risky and I'd suggest
bumping them to at least 32mb. The vram portion can stay at 16mb, but
the graphicsMemoryKB can be safely set to fourth or even half of
memsize (in your config 256mb or even 512mb), which will make the vm's
a lot safer and allow actual ui usage because with console being
pinned we just don't have a lot of wiggle room otherwise and we just
can't migrate pinned framebuffers.
The patch that "regressed" this makes dumb buffers surface that
actually respect pinning, but as long as you don't have gpu host side
things will be ok. Otherwise we can't make a config with 16mb of
available graphics memory and graphics acceleration work.

z

