Return-Path: <linux-kernel+bounces-436231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227789E82F0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 01:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000741882F2B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF08493;
	Sun,  8 Dec 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3wq0jxz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D56A29;
	Sun,  8 Dec 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617915; cv=none; b=RE6//ZVlBqBOegCYS2BsWQ63cNhY1CPBRk1ZyvkHoGcdyAyKpHZ4CuEhtwb1DYVhrXzVCNK1GqaoJc38uRoByD1sWDRfB1E6J1Ma6HrahOWB9BIrl16PMrk5/UoP7qbkOBbklvbIrBLGZPSeVKFuSIuGfDXWKS1+KNY3VH6WZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617915; c=relaxed/simple;
	bh=InVy1a0aJcLsRDBJuhuN8ZeTyTOSc+DCz9w9GJh5qPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0FeO1OU6c0mDOXJQ5vqIHwJagBJe3fBK60M9WVQm/laPU5FyRMTfsgL5fm3pvxOAsSMhdB3jMYy3u4TlUORDD4ZKFko9IChTRWSfoLm9NPOE1f7+O/bfojeQBC/J9rykeywLf6h1qhL+xLYlvcdvWBzqAGzFagsck7HedlV/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3wq0jxz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7259a26ad10so2586429b3a.1;
        Sat, 07 Dec 2024 16:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617912; x=1734222712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmWqSvwSCcwiNCtDTpyl1fgEz/eE4sOR76a80cLtGDQ=;
        b=V3wq0jxzB+Vq43aDL3Z7PvJW9xCD74Jfap+gS/Lwg75yyzwKlnSUYFEu67adkQPDxQ
         8r3KwpYKGDYRDDyBfqMrKFTFLa81sopzWlq+radxpdzerErbb6H0EbvjSKgTdj7qpLwK
         lr+g/zVxb2el3aI1s0LukZqmiYq6VbFmMmqB7tfu/fJ4dKeHIknytVHtCSoiTkWb7Xjq
         NoD6Rkik7JohdkuB+euqiDEsR192l6JtdB2UJoEa6xMGCwCbLrR6tmBNYkw/LoVzWbPg
         jxfHaVcjWOE2B5PvOB0lhDjK875s7G9rVRIvM7JpGx/4H3fnq54C9kmb0sc4dKjo6keU
         lX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617912; x=1734222712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmWqSvwSCcwiNCtDTpyl1fgEz/eE4sOR76a80cLtGDQ=;
        b=ARPdsBBwZnu3KL7eQrf3e+awEIsyOSbeazv5dpRDz1sFBb99bnIBRmpYfaCU/VuSdf
         baGkoVqQWVl6ZpAAPTrFs3lUVihSEfolSNMdwF4tlP4eYEOevV9HBviKzVdqBv87LiI7
         kSRrvsC4pU8HdHSb+UbeTD0RVZfF0l5vYhXORIHPTvMxwxVCiX+dImDGwVmebFSxZ/RO
         luM+4rdqUi6RefSDv9pA06yPrRB5D+gaCtuikouRjrfX+IlW5kBHkmcXJaWl/YaXtYEf
         2ddnP2TGy48DWwdvl/9sV5BnSRHw8ZpHvcjrWQm8VLcedcIm0v9Pv206UVVlzv1v6/NG
         bmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA8KWxkcx7a+URWF3NkTwjx4dK+hEu5dXRApQo9YyYvWaYPyoOKnRUXkhhdn6DvqbieiftleCDKPAN9R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPOf0RA+ePz8OdQzo420IeONT2bUK4VfNEsXxglh7VV4DG3+W
	TbzBhgexbuI79lOmXrU93irhELIod9dsc0qSknKaghzL6Vdp5oMpkp8r9w==
X-Gm-Gg: ASbGncvvWUHF1kg8Qs+G5kfpwwFBMYys7FV5i0H4gEUbg2gxNtuGT/1fbv1+QHmKvTY
	6auoE6Q2y2GmQeKhKwK7QF+3UCIOrrYSCGFZzNwxMXnCLzveG9bKA4IJdhsEVQqHHnTWw670yo1
	Vu+EAW8o76+w8UQushtcxl4exU0SZwtrqrz1teuPeXXGY1zTXphveC+Ffj1mGSGUp8/fsFcOXwU
	1JHXx766Wn5cjEhwu/XX7Ehad1BQkWa12Bg6gkdNhf0P+3KkGdZE920eTJST6KhNoA/Lxn2SAEO
	hnnctbsk3fwqpNE6hIMwxl8=
X-Google-Smtp-Source: AGHT+IElBvRUycNJAnbsk3M8EMXw/Issl7xZRl7CydnhvlQRF7vTgV56nExPUvVXYzsMInzPYTaSow==
X-Received: by 2002:a05:6a00:18a5:b0:724:db17:f975 with SMTP id d2e1a72fcca58-725b7e3be34mr14853182b3a.12.1733617912369;
        Sat, 07 Dec 2024 16:31:52 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2cc6ea2sm5144554b3a.186.2024.12.07.16.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:31:52 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>,
	Cihan Ozakca <cozakca@outlook.com>
Subject: [PATCH v2 2/2] alienware-wmi: Adds support to Alienware m16 R1 AMD
Date: Sat,  7 Dec 2024 21:30:15 -0300
Message-ID: <20241208003013.6490-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241208002652.5885-4-kuurtb@gmail.com>
References: <20241208002652.5885-4-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support to Alienware m16 R1 AMD.

Tested-by: Cihan Ozakca <cozakca@outlook.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - Added this patch
---
 drivers/platform/x86/dell/alienware-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index e69bf9a7b6c8..341d01d3e3e4 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -241,6 +241,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_asm201,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m16 R1 AMD",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1 AMD"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware m17 R5",
-- 
2.47.1


