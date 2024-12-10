Return-Path: <linux-kernel+bounces-439193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8D9EAC10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4891884F41
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F302080E6;
	Tue, 10 Dec 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HEFYh1Gz"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E71DC9B4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822942; cv=none; b=ClUkHxzP+TZGRHrD/gm9HiwS3847jbN7BujTLY4Wb8Xz0xEtbKmR0k5KYeMuLftioFxQVXVTjLKJCWHcZ95FIwG0DLzfuma8LZoGK4feK0Df/L9rEj6btcFjMTNSbTMcnuDGkkYD+L8Kyf2wj+rKdT0gcJS9LgNpRSMk/NWbzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822942; c=relaxed/simple;
	bh=Kwv/wusL3b84HhR/u3oJDyjPqtdw53INZ92ugbbfA2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8M7Ol+5sDzrUqhg1sTjiep0hF/r0I9NU+dlj8x9qHZTMh8k6/RhlF0i9Wyo9IMJIFRehcO27XgeZIb95VcP663iaGmCW/GRqpqx1YgMv3pnSD0CYvc7CvQ4Hd2RW8leny4K9fSWb/jiC/OmZa4lh2gTCCIZ8YeSMnkX8ccsw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HEFYh1Gz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6da2d7884so110512685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822939; x=1734427739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yvntl3jvEfc//x9pm27kdXuf3uRYNcagoSWI36TzXug=;
        b=HEFYh1GzD/2YzB5LKa6KQhG2Tx1VaQrh/REseLNiH9NRm77HoILhHfdib68K2080Fo
         FjfsxXVKIOaMeY24zgPQLGR+HOOruicZPlDGlVlwyt+nIfRNRI9ZE4AkPp3JI7vOZscz
         w8cCUNToL/wYaVHTqqxF3WG7TiFmvqzTYLjhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822939; x=1734427739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvntl3jvEfc//x9pm27kdXuf3uRYNcagoSWI36TzXug=;
        b=Q9/i+EtCpumuCyuGpeQTyiLKE+Hzbq9VqB8wcwBrY69h/sOUGX8gJew9v1ZCp7/+sA
         HlVOpgE+lT8hk2IZpWdNfUthdrEKn4rIB6mfop9MM/E/zCK823FjEqGq28YwBUPz3Ik7
         EHOWLEy1XIGmIjjuoE4H7A5ol0GTLJI3Ctvawo+HEcQs6ogRduA+4lDwJzhK3OurkoIc
         kXqH8N2aN26K/1PyPcdM1DrBnB75SgR/eQZPAhDDxZy/UspCdPFEamGVDyaf6+TRnVmd
         5C5G04Yk89c6AqYpaAo9ATSuq/r/hol+aJjVKxU5sc0QmBuWdZPPmcdOvak6zwBchj+b
         cSXw==
X-Forwarded-Encrypted: i=1; AJvYcCVbcOBZUdkw25YOy4tMtJd7PiuCyE4cqPrHVXgfclchCBfKOMsVk0Crk7kbxQA2SGp9QQMQIY2/mINL7xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnxbILRzrq/pWCOmCpu6YxXpdT0yJjK/g6E5lVYAjFNI1rQgR
	p/fQfhCAX7by254pvgY4UjqTlLhiuke8r4L2rlMG2T9g9+StPe7xmMa+raiSSw==
X-Gm-Gg: ASbGnctEvBkmm/mCXH7YQXXeQXahR+o15UY910u7YOx3kDKXhkKBe+1Wt3XVXxi+J94
	sN4Cq+IWChkLW5tmvg8WwXvDfKpkaXToSSfEZfm9E36tTboN/07huGvF9NdQhiNSTPKZf7XL60P
	46UtDcWMzOvkjIInsnbafCGWT4cfpphFbIjeOez9TpMuG16QKflXjCGjpuLPqvoqNE9nPtSiS4x
	/m6l8XgnrVHODuH6rRqLJrc+eiyHD8jvTocPcnakI5TJSJhgc4VXpEOa97cmKJ+VNx+WP9XgNDQ
	XZinIE02WvVg93kidXFra2HtsIu+
X-Google-Smtp-Source: AGHT+IHfGjM3il73uzcVVahBJWJV4voLVQSpqP4azfgSBEzlCLsR7XuITVeqz6peN1GDRvj/X2uvew==
X-Received: by 2002:a05:620a:262a:b0:7b6:e8d4:9b89 with SMTP id af79cd13be357-7b6e8d49fb7mr13352885a.34.1733822939131;
        Tue, 10 Dec 2024 01:28:59 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:50 +0000
Subject: [PATCH v2 06/11] media: atomisp: Remove vidioc_g/s callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-6-c0a33d69f416@chromium.org>
References: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
In-Reply-To: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The v4l2 ioctl framework can implement vidioc_g/s_ctrl with
vidioc_g/s_ext_ctrl() and we provide those.

These are the last references of vidioc_s/g_ctrl in the codebase. We can
attempt to remove them now.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 6b84bd8e6cf3..1fb2ba819de3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1565,8 +1565,6 @@ const struct v4l2_ioctl_ops atomisp_ioctl_ops = {
 	.vidioc_g_input = atomisp_g_input,
 	.vidioc_s_input = atomisp_s_input,
 	.vidioc_query_ext_ctrl = atomisp_query_ext_ctrl,
-	.vidioc_s_ctrl = atomisp_s_ctrl,
-	.vidioc_g_ctrl = atomisp_g_ctrl,
 	.vidioc_s_ext_ctrls = atomisp_s_ext_ctrls,
 	.vidioc_g_ext_ctrls = atomisp_g_ext_ctrls,
 	.vidioc_enum_framesizes   = atomisp_enum_framesizes,

-- 
2.47.0.338.g60cca15819-goog


