Return-Path: <linux-kernel+bounces-539287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50269A4A2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18A87A7F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B962230BC5;
	Fri, 28 Feb 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSjRNMRI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142A1F874A;
	Fri, 28 Feb 2025 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771760; cv=none; b=BhLwKCk0hvC0Wu5vmQxngP0zg35/sGU7mEJQvmo6sZ0xtLzM7eYmRsbL3o72KiKByKXXd5d1BoEawK8VBmtb9urH86z6yClUW3y8Ii1ZwW4L/8j5fhmW4qWLoVwOCYPBYCxudtlaoJMRfjBQdCZYWhsEH8UKW54FiEjq8Mky+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771760; c=relaxed/simple;
	bh=ER+r8NXmdkWggNU0HA9uV61RbAhrlmzZHANxsH2Jtn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mD8AOSaZInKGhiQmAGLay9Hb98drLcKqWTnTkAdwPnbyQ7IlqtX8jgIubVLzil5eofZH+Jfe7AzNmRUSuHjnAbJwX5wCtYFUDvtAEEbmp66u+xKzLPCrw5xc7exDHVq8t2sqYTe5bXPOldoYuODQJYFYBBf3V0i784RBhc0lRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSjRNMRI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30797730cbdso23748961fa.3;
        Fri, 28 Feb 2025 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740771756; x=1741376556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER+r8NXmdkWggNU0HA9uV61RbAhrlmzZHANxsH2Jtn8=;
        b=DSjRNMRI7EZCIeABKzeUL8q26tntstfEUfEs1+zj9xV1tNuA1E1sGXhLvVK1anAIKP
         I4yQ7Qv4Rr5r0CRITnGargvBPf27EyNr944wwj/7jzOsFQ9O2phLdvaLYh47piA6/Bj0
         KsxkkDtxZ0quyl3Wtp4qnxT0wnfk/FQLFrAo+j795/zCiuk4uDUzyQ8bH6Vutu39PIwq
         hIXn9LbOitjcvYVrVi82x5vNnLj08grq/IVuCnExo2PatdmIf7hpVBLLgw3/m8v+4xE3
         qpPFYI48ZkJExz8Fu2SY5/zHbtrfWRtbudPUfbVDyBXl1NUlk8cWIas0Xz2dQ+vxW+eG
         mdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740771756; x=1741376556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER+r8NXmdkWggNU0HA9uV61RbAhrlmzZHANxsH2Jtn8=;
        b=vAIhu8VAiBxfRXDAiy3LMITgc2nbJI0v+XEhkT6UxG4N4EYXOyYSj3OikqOK7G4IJh
         rxxnlDMXvvK6IXNd/JIo9IMVxa+Va1xoOduM9xSfvVuEHIHFeJEbohCm7wvL2UeLI96b
         ggm+p2rSc6/7JI6jW1NoM80SKjFeaZRvRPp0STbqgtAVojUd+QfY4LO/fiZ3oembmGIQ
         J3qlfuYkHVjG1iGCp/2c520puwlEKyTvmqGf9daxCUjdXiLYQ43tqJYW8BObt/Ov69pL
         rypavjOiTqDHkXIPSaLlIz/P3vlQalTz52gv26DKh2Ja3qTcdVt1YtldBpPW48KsOI7t
         zcUA==
X-Forwarded-Encrypted: i=1; AJvYcCWRdtduq6j8NjRWIHnLljCuKt/gmbea/Haa32FKhwLkMpqIFp19QhW2g1HXG5LaKr1fjIFY3lsBeOmQHkBb@vger.kernel.org, AJvYcCXyXwkDB3R/zQ6jHuOwCw9EZACzBh8ZfaeMPp++HdfUY9YJEwBs62bCz0J4R6q9baMFL3iARx7NuqoI@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbVZOGrDPTFAEZyA4NEHENBSYf4isjog/ZsKTuWCGO0DX3qUn
	2fbCm59GL/lTGCZOV1tK4msOpcuuXJ/T4PwfozihdxuuPWbNOm5PK7NQEm4mQLurhV3MVWSqqCO
	QdafR0dd6odk880isjgsrLnKt5/hToDeM
X-Gm-Gg: ASbGnctSDEa50izWh9+kKQsMJav1TZPTeg/2vzLx4eKhgxEDmOdpZNigvZVP49Vg3pK
	7+8iUqiaRAPlnYwwPHfIF6M3NHsLiuXvruUQCGa7EGWCYrH+b8kvqVIx2/0T+WFuzY8axieADIx
	W6LSgI3795l7iAhikk3NjOjqijiPw8EuzJWRspwA==
X-Google-Smtp-Source: AGHT+IF0kZIiHzdFJYX2bvCwbKhMQkcQPj5hmb4BkhewRGIZt77ta8Te2nCI3MxmD7G1uvJYlftQUPlvNFyy6H3yMRA=
X-Received: by 2002:a2e:8215:0:b0:308:f860:7c1 with SMTP id
 38308e7fff4ca-30b93418c69mr12907051fa.30.1740771756188; Fri, 28 Feb 2025
 11:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227170556.589668-1-ernest.vanhoecke@toradex.com> <20250227170556.589668-2-ernest.vanhoecke@toradex.com>
In-Reply-To: <20250227170556.589668-2-ernest.vanhoecke@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Feb 2025 16:42:24 -0300
X-Gm-Features: AQ5f1JoDhtvIJKnD6zt795G88ZFNlnPp4nsAKKBjoBY0YUhUy9idNheY0yKrIcI
Message-ID: <CAOMZO5ARY0P3nNnh6tmLi1p5N0uXb8ZLqkBs3ZekXD4U_-rOww@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:06=E2=80=AFPM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> Enable the STMPE811 touchscreen in the SOM dtsi files. The STMPE811 is
> part of the SOM. It's self contained within it, therefore, disabling it
> is not the correct default behavior.
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Please run /scripts/checkpatch.pl and fix the following warning:

From:/Signed-off-by: email address mismatch: 'From: Ernest Van Hoecke
<ernestvanhoecke@gmail.com>' !=3D 'Signed-off-by: Ernest Van Hoecke
<ernest.vanhoecke@toradex.com>'

