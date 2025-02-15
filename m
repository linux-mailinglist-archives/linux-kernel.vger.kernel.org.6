Return-Path: <linux-kernel+bounces-516410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF418A370F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2F53AFCBB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40F1F4184;
	Sat, 15 Feb 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANQkPYy3"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEADF59
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739657471; cv=none; b=OPvsJC19I0OfKhiGrj0Ug2jdnkS44CmLZq7vT+yNxYRujMXfjjEL6htTGPWod4OmmTC8baT2MfO5DHUDVl53/50XzzQvMFH2DGDB3Jjz6RIWSggjUYkT0B7dXail6aXKpQGtL3BhUgnwVoLeTp2KwO0t4TfONnF+xg8Y+xARflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739657471; c=relaxed/simple;
	bh=tq4tYuCKHVPUaPS4ZFMSdMUuEVTzbw9gduFxt5d4nyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MahYO3TV9YGZOkD9OtqPdmcR2W/5IXjxIOgXYNhy3MQb0IWBK+QPqPm8OQGsESQk6wuDpBIVAWpAIyBzCK9Zp8F/a/IrYhog7l4t8aR+AMn5rEAMPYWEYkFP5JVJM7Q78jzI1SnzUd4MAlG1FC6VBUAz/xWNxQUKv4qhiadTz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANQkPYy3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5450681b606so3120054e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739657467; x=1740262267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CY5LXGN15DKUHwL6v7Eeasop1ObVi/Ph6DDcrE77SvQ=;
        b=ANQkPYy3j464I/D6eSim/4+fEcl2awNN6yRoaL/zEJNUV2WFfflDxQ/QavqqTqfHVi
         BLl/HBMz/jOmhxU67r8Xw8hlIiadHsz5cqKOfPmDiZwLRJIrUVx5yXlrL9MowGKwVMSL
         nJivlPPt4+aOWe4FTAtMzkNZe07ASIi0QHEYZjFZYfErGpv1sc2n0B3IAFBRAntO7vXe
         ktpbCUshyoPANjt4nhXSjG788hyBjClxKtfTEhDAiYuarWF1q3c7wh3EKqJZlo8nE/a4
         6YmJ2b7RFIRvmwcx3nW5xjuw7NZnMywZ6xKwpkL3BdnQuO764W0q2LuHh66cWwYmGE+F
         wxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739657467; x=1740262267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CY5LXGN15DKUHwL6v7Eeasop1ObVi/Ph6DDcrE77SvQ=;
        b=nlFXg2hSOBvLkz50W1KS4B8Sy2lP2swxf3heIdHBfpif1JA5SrIWyWr9Vfa3Ng2+je
         iDB7WuW5YkDrz2dKt77M0OH3xw2Ju20mZOb+4W7ryJHtyQk6Dc3Yy8DSvPm+ONKexzzO
         F6cqNb8tkE4EMNEaU1xdGpD2TMeFqU7yYx5XAIuMTxhF88JTfxicFD+pY3U+wCrPwFum
         SBpKWwAsPjAYxbIR5d93ljopQj5UY278WCCAxJRvbFIK1LOq7PRwweiIPaVmNOSI9hwi
         nVJZO03jDhtc9QZs/cnXA++a7FHBJcbj+jWtWHZrFr/Q78coVIh/MLtDfM8QwUumHp9u
         cJIg==
X-Gm-Message-State: AOJu0YzwyxGkR1ag2XNjqB5uYDN2a54+XqtmWBjB5MrvPcd9AJFCqDNV
	+3nty5wnFylZFWGmWIGi0dd1Q001ghduZBYQDGSAleTDLtTX2X3MosRlsl0lPsSZ6/WETJCc/5P
	oTjOVqVpna8dmt+qylxLdhiQ3qA==
X-Gm-Gg: ASbGncvAKLBH4KhTiscQ5ujNJqJWthQcyeNfeVSPCddu2t/iX1E+nmVjnKSstcmY0tq
	nTadrOWIHMqGR6EXpGPBn0MlInJFpaviWYWbMqZUNk+jucnZ0OEtlrPkgotlXpN8ubIFIBDpFUL
	ly/N6lu1v34hY=
X-Google-Smtp-Source: AGHT+IE9CjmFCU2XPrI35erAS+Alz5jIurnM3UdZUJLero3HrZT13QvVmZNGGEo02QlhmYC64hDgNwze/jvzczoozck=
X-Received: by 2002:a05:6512:238a:b0:545:2300:924d with SMTP id
 2adb3069b0e04-5452fe3f69bmr1563768e87.22.1739657467077; Sat, 15 Feb 2025
 14:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-9-brgerst@gmail.com>
 <20250215142714.GFZ7CkQtdXoUM-xKMo@fat_crate.local> <CAMzpN2h05N+KZzpFY6YXZjMViK+_U9gks36mOfRJpSOMY-Xm5A@mail.gmail.com>
 <20250215211854.GFZ7EEvlYTQ2USmKiW@fat_crate.local>
In-Reply-To: <20250215211854.GFZ7EEvlYTQ2USmKiW@fat_crate.local>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 15 Feb 2025 17:10:55 -0500
X-Gm-Features: AWEUYZm2KdxnaLLUoGt1kaLcKKiHCA47Q8gFr8x1y21_z4Iv4FlS5J5LDF0APpI
Message-ID: <CAMzpN2hTYCB6f1v2RjzCZV_Kx0WjVzE0U1ALhZ-C=Rjya9Puvw@mail.gmail.com>
Subject: Re: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu variable
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 4:19=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Sat, Feb 15, 2025 at 12:38:21PM -0500, Brian Gerst wrote:
> > The convention appears to me to be that all caps are used for global
> > variables used by the core build scripts and/or exported to
> > subdirectory makefiles, whereas lower case is for local variables.
>
> First time I hear of such a convention:

If you want it changed, please just say so.  I don't care either way.


Brian Gerst

