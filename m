Return-Path: <linux-kernel+bounces-231631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA10919AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB71F22CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C7194148;
	Wed, 26 Jun 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjNsUUaV"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F319409E;
	Wed, 26 Jun 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443138; cv=none; b=jR6CyVxCgOZeKkWGq5yN4grVIzR/b0aqAwTuuRiEAbmR0WQMaBG2POx2zAC8DxSlCEqIP7/FAmorXUH/ItLKgewXDVotApspcvJkP2GV90q1xoPb4h6I2igv0xCLuGOyrWWHUidM/8iZF0nEtogzQug9fh/kgJuizXSiwoW1yMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443138; c=relaxed/simple;
	bh=jVXjFJo4/Hla9uGL97V8BAnKgwBZCr/pIAk8uiQ0ufU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oWCQNtfe9Cdfy4p0U/1txwLh139n69OslbuqCovLAe8N51jBbhvCofzBbMisT5UQYj0HnBJ0Qrs3M+9nueGmrf/MlnGED0uZNRxy55+eqUm24Cikf3qk/KjLdill6izOvZJkjodEg+0QQ0QQr/WX17a15fEazKbT3VeQoRH7LiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjNsUUaV; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f3ca6869e8so69649739f.3;
        Wed, 26 Jun 2024 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719443136; x=1720047936; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVXjFJo4/Hla9uGL97V8BAnKgwBZCr/pIAk8uiQ0ufU=;
        b=DjNsUUaV509Eym5ING32Kpi/X7ybM8oIuM7icehqin/KubwdRD55LMbzuQNVf+Llxc
         Gq8TS61EuXmXwoTsYcVzRnKi59Wnj3ireQNT1c3Ds4KwrbIsQl8klfAcxWt1QP4m3O1J
         bM3uy2BI8z52HJuj/7mSy83JertBXC6NrhZWVC77vQDxfI0dViM1H09WC4x+d27oipSR
         6vLhGAGbgFijelgFFybQgKcUAokl3MxMdP6rogr/s62He0uGHwCVTwviUQ8ifeXYdV8S
         GkdXDtLiNeYfgL7oOWoxihTbNyYZnrembAncTSewsOILmiQaTRMc0Fpw0JtfqBd5//Km
         P1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443136; x=1720047936;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVXjFJo4/Hla9uGL97V8BAnKgwBZCr/pIAk8uiQ0ufU=;
        b=LUuNmpKQ2ngO3NuyhlffDvSD+Bv10mBRgrHQ1BFXFEM6+ndKpsMRXNDImLbDhUgnh6
         lPicpLqsGSKyUcIZ4oLZ2kf5OG0ZzaYnsdSqodyk/ch0ZdVh//lgitvY/BupZjtbhnwJ
         QX1fqzdRwBQTspzE2IrPH+J4dsaBNHAu2cR+6EjoQwWz5NoVWiJAfazO9Ke9ktQQcMjE
         p+Iou3X1FwTzFkVzyIkVW/15c54CTknURxorGg3u2a9tylSD37fo321OMNVYjwr3XqEn
         UBqox35yEdRbVoloSemjlLX2BOJkGLwXwDg+P63ncgz8eopCL50c6VyEqkZt9Psv4szB
         8Jhw==
X-Forwarded-Encrypted: i=1; AJvYcCWljRN18bwvB4GGzTASjrJ88UaP2b8z3UakbJM5VEtR51rTch2k84PEPXiEDLnkOoM2XPSbdkhT/bB8syEESnUvzrKjmAABO/1oVrTDpJjd4QXLLhCP1x9BnOTLBxGDxZTG1PHQMuDMW+8PW1w=
X-Gm-Message-State: AOJu0YyxxQ1zVZCb/kJI6ClGb+zSFbZhWZt+AGrQ0Kt+xuJmrIZ1M3Eb
	ACVwd7DKmyF7BU+kY9CYy6ebpoxjMrWQXnxKXERc8LYzio8nC2Fd
X-Google-Smtp-Source: AGHT+IHxB9l5av8Bx0kfv3foIdkebE7MTO93/hxxyc6mc7fKbsRxLP+xrogJhr3js/bSJTDlVihjSA==
X-Received: by 2002:a05:6602:6c11:b0:7eb:b188:1c96 with SMTP id ca18e2360f4ac-7f3a74da8f3mr1495360639f.5.1719443136282;
        Wed, 26 Jun 2024 16:05:36 -0700 (PDT)
Received: from localhost (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb6649d850sm37306173.51.2024.06.26.16.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 18:05:34 -0500
Message-Id: <D2ABPZ1ZUV95.1GDPY1XYSGCM@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Aswin Unnikrishnan" <aswinunni01@gmail.com>, "open
 list:RUST" <rust-for-linux@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] rust: Enable test for macros::module
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 9999
References: <20240624030327.90301-1-ethan.twardy@gmail.com>
 <20240624030327.90301-3-ethan.twardy@gmail.com>
 <CAH5fLghDZdt57SShnzUx_ZeBquqm-3fah3CK9YAwMYHAJdteQw@mail.gmail.com>
In-Reply-To: <CAH5fLghDZdt57SShnzUx_ZeBquqm-3fah3CK9YAwMYHAJdteQw@mail.gmail.com>

On Mon Jun 24, 2024 at 3:32 AM CDT, Alice Ryhl wrote:
> It may be worth to call out in the commit message that you are
> changing what the example does. (But the change is good - this form of
> kernel parameters were never upstreamed.)
>
> With the commit message updated:
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Oh, also, you don't want an empty line between } and `# fn main() {}`
> as it will show up as a weird empty line at the end of the example.
>
> Alice

I have these changes made locally and will send with v2. Thank you!

