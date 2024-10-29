Return-Path: <linux-kernel+bounces-386343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307699B422A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35CF28366A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB82010E4;
	Tue, 29 Oct 2024 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLa8QQgp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F47464;
	Tue, 29 Oct 2024 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182338; cv=none; b=XAGHiTQVeNQ902qnB0lPjfZd6wjNs6Q9uhNMy3RVTKVBbh3pvogLTUEX7nyIYO+SeUffuZjRXe6/XMcsMGeX/1LgHCEfjzvPOxdqx7gbQl8nSF4/fAxnWP0b17cU7/+eiG8wpp7LwH3EczL6x8lFr4oa504i4rhoyzMx1+8eNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182338; c=relaxed/simple;
	bh=Kzk8mG3w4M0DJo16dim3KWCQXCsAv1NmNVUeuFf3sBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9hWV0uZbY/B638T8RJV9LeB4LQQUJbw29CZC09uDg9jwzVFlMGPQX26zJ/Wk8/bPWZnybFAg6MxwuinfQIV5RxFGQkDfJNVAoDCxYNfMGRniZ6LBfGyLwKRzORZ+hj2JNA/up9xIDcjAQ6vub7CjCXXZtAvB6ZXhfdLPhpfxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLa8QQgp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c693b68f5so54159355ad.1;
        Mon, 28 Oct 2024 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730182335; x=1730787135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kzk8mG3w4M0DJo16dim3KWCQXCsAv1NmNVUeuFf3sBA=;
        b=BLa8QQgpc//k2XGf8TbrJ+SQEdLrAeq8HU8JiOTgg92Ug8X5GR7bgHkQx7BRFp8sZ3
         15OSG5PE45pK2eUzCSa0GS4aSh+GpRLVGIEtUszcYTi3rpIllKQtliuac5ESVCaZmo+R
         +/4DMzYpSIexBTZ01iUHLDz9rsqjxfYkoc+UszN2xskyB1uSW8njvKkBFnyFYUV9ZsJL
         Kj0G+WHlEHv9502/ACzGUBEmRAK3xDmzFbh+OpBX4/2ETncCCoMs7m85/YOoz/5rm4DY
         62cl9XXOWnrD4MdrX3moTkY/69utoCoSP7iZddZ901tw0Zkbf0dW7Ap/gDB/UnoQD2hG
         AB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730182335; x=1730787135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzk8mG3w4M0DJo16dim3KWCQXCsAv1NmNVUeuFf3sBA=;
        b=tSiK9EZ+QfoBW2gGFrfYbeVkJ6TTSguBd+RBmlJe3753T0mYsI6IhHorpuv2v1uMsD
         Svxf5T6l182aPSFcKl8+bvZFcc2hrxutdiv0QZXhKQ1wX0M05zHfyww62bWhmA3V8hfI
         Iv5Jv3rVmz+8qgWqAcKKBFEWDB+ethQEdddIKQdVhB183b4WIXbCnb0F8NB4HHwt55YZ
         G1jBgPmiXZBOCQpzmKzJd8rHjJ0SDrHj/sWwP28qQb8IilDaETz0OJcfm1LEVFGOM5+7
         v53xP2OT4SReS+Tm8Aa5JtCpE4wKo5OcSa1UgKvxAKKFMUu+rSp89CHKCy5jj298qKoF
         C46w==
X-Forwarded-Encrypted: i=1; AJvYcCVsr86EpSy3Tyb0u70plmZnG1SVrcE4+kXWGE5l/xHWLkDK6KkGjKQ8qZSnjIuB6e8sFS2ACdpsKpYpRNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1fsnod8nTSms0A0/JpDzpb7w3o9nIXYOPlPCW0XmNvsj537g
	pOqJTwWd77QSuMtfB2wCo8PkEQHb9CgmRMj89jhkYjxxlZkkoaOUlWKQuj4cg9+P/7cmnq9FzXw
	Q8ZYYhqZZjZBmUsHWXn9DseVIoSDa94Rjw1crZw==
X-Google-Smtp-Source: AGHT+IFDmIyepVPsDIv/cyWTJ48jhP7A08uiBSPpB/uVY2dRCd95mv+BO/Aq7Ks9pni7Zgx9IIgOqPLaqsYkL+GoGv8=
X-Received: by 2002:a17:903:192:b0:20b:7be8:8eb9 with SMTP id
 d9443c01a7336-210c6ccc963mr138766145ad.54.1730182335142; Mon, 28 Oct 2024
 23:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728818976.git.hridesh699@gmail.com> <32382c55dbcb6482d6e686d541c2e15b282908cd.1728818976.git.hridesh699@gmail.com>
In-Reply-To: <32382c55dbcb6482d6e686d541c2e15b282908cd.1728818976.git.hridesh699@gmail.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Tue, 29 Oct 2024 11:41:37 +0530
Message-ID: <CALiyAo==Bk1qjVcnQKc+0YUOzgKuYSvJts+eNrMDx+E3XxMsGw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] checkpatch: warn on empty rust doc comments
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Valentin Obst <kernel@valentinobst.de>, Patrick Miller <paddymills@proton.me>, 
	Alex Mantel <alexmantel93@mailbox.org>, Matt Gilbride <mattgilbride@google.com>, 
	Aswin Unnikrishnan <aswinunni01@gmail.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just dropping a gentle ping=E2=80=94please let me know if there=E2=80=99s a=
nything
additional I can do to help move this forward.

