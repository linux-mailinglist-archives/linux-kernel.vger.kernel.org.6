Return-Path: <linux-kernel+bounces-210798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF4B9048C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28978B22A92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 02:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD39B65F;
	Wed, 12 Jun 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+nVivof"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B640AD54
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158339; cv=none; b=JfbXnfOQrrrEzH6pNwAa1hBxClDv+TCCtu+hIdMg81YW+hJk6YLb4QzLUyBmKHGN0ZnZrI0Vw+3xGAA+DvtQn8nEpEHOpwgz2+FFOfHsVqveTpyjITUtRrnBUSs8ZYp7g9UDOboMHWOP5WF4l2XucQXkDbOS0YFBsT4Wy1jufAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158339; c=relaxed/simple;
	bh=ow+WRcEvA3pNIVVf3fLydRk6hOHg4krSLYZQDJrwoAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WgIjk7qMan+oMihUYVIfPYivZANe3n4VaOkwNK0mzGuxS+lP0EUr1XCsIWBd7sXObc4BtW4Lk6o97LAnvWO9KY7AyiohTYKIuomek5MkJm6319YB/ABWQP67s6P5sAPkUBYGuAi/n4DGpN/52rERPNMAHUY+8XJ02Qmi+YvHX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+nVivof; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfaf7ead784so9104959276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718158337; x=1718763137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHlMYhGZxnwsaOysx25sfHBbHxJf0WYTlqBZxa9fVCg=;
        b=3+nVivof5GcnTeXBF07QU5X3jEbUq/IjG4Wvza1U/forBA8xtGp0Vg0UwpoqJa5cni
         5za/N3M4cL9gcZ8k8JoM+XecXelFe6TVe0q1wwjDCgBx5g0bhjUByBwSOMLlolY9AgnG
         oTBvVrF2JR5MNN87Ye51SxCzhmKkAgts02Ifvk13kNLnNetTDmO4m7l4hSF/uB+OnNHY
         9Ump2LSd8soi8HXy4u1LqQD7aAxfBJHm3sAQNnCicUZ7SYK/zKbDczdtB5nZNosHJw2F
         mU/0ggkg3A8/nt90oXLzz642dhxZn9+KyOc6t30jneEVXijVXM/0guO3ZirdCE2dyazj
         iQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718158337; x=1718763137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHlMYhGZxnwsaOysx25sfHBbHxJf0WYTlqBZxa9fVCg=;
        b=v7Q8LhKY0b7iGiYnW+AfuqUK1gNpLarPYxRdrYoQkKBV+Sfbx8XXnhGXgwqoYAN9BS
         GpoFOTCXKpdvs39s19S1l5OJDzWZtU2n0a4Fh7QkWMcbUDa9OCkujk6IPPEE/4uV/Nwo
         Rr9fDd1fl2BKNJUOI1MuhSd078w0ceTf7Ua3Lnkwk5rcy8rmKNvlKwW0EDJusft/mG+S
         bXayhjAzxFZlDLOtKTmHCEQa1bYp70L7W3mi++mO4+tf0CgEfnVbti0XZKDJdaoNg9+R
         ng8rlbzuCAKDvj+Npp+zcQORyDxuGYEXLUxi+iuT7+X1qje2gvb+l5pF13XJT35Cr8Cd
         I+zg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8q1gtrEa1TgSPZ/Y2Ew2udJzZ7zMU04vzsr/NcHyW0ARdfrzPYbJAK5/m4nnpGgymoOByub5egukwkfkChRLYkzytBz+F0g8pqZ6
X-Gm-Message-State: AOJu0Yznhtyqnz6J5JQCTuEcwU1VKe5e0JRCWBZB7GL9xA8OHNxtHZnT
	RKTcuo+K/V8QFb1B5joMYjr48JedB9NcAF+U4R3NR0nAOMnPwWzmCLhFA1xZYDVVgJgllezkZP/
	3+QIkjw==
X-Google-Smtp-Source: AGHT+IGt4ud5/3/G+1KJieAAEUKdvmhQo9Yatp2D5Uch0hGD63q/smE91xVBjPLMSedGoXwnETr8/GQkwf7q
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6634:9477:a468:5a8c])
 (user=yuanchu job=sendgmr) by 2002:a25:8702:0:b0:dfa:b352:824c with SMTP id
 3f1490d57ef6-dfe66b65314mr108148276.7.1718158337485; Tue, 11 Jun 2024
 19:12:17 -0700 (PDT)
Date: Tue, 11 Jun 2024 19:12:07 -0700
In-Reply-To: <20240612021207.3314369-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612021207.3314369-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612021207.3314369-2-yuanchu@google.com>
Subject: [PATCH v2 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dan Williams <dan.j.williams@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..5e661f39e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.45.2.505.gda0bf45e8d-goog


