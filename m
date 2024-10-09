Return-Path: <linux-kernel+bounces-357428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ACC997120
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B423F2812EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36711E282A;
	Wed,  9 Oct 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cea2cNNE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4D1E2843
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490151; cv=none; b=BP6dVaqAm6mZEN0+F1POJbMmONC7W1b/oZ3nVaJzVzvnVGePAp5LFrUIc5FBKaAJziln1A/2HYWUWTKH33IBHeAakFU90oBrHiheAmuqKYwSEQLw+K5/1H8vQPces4u3DEEOSeDKq521uSQ3X1k+xF5i6Vv9ImEkgS8ujCx1Ajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490151; c=relaxed/simple;
	bh=9AwPjYKc1tTHReZqpWWep5mg1gQzX/K7LnvZvyHbqdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2oM7a9mLJZFSaVxNAuycp8i5oaYP+MF0fdMCWnsjRcLY5OKSCuRzVed8rSfZHPqvrAO5XkZtwZdmy4VnufUiXEvDmvt5MEBQOyYTv1JsKMtjTdSdViDsVGeutl4cGuAXiklqly8qmUVK4yG0xYctXMfEcyHhUdiAQj/+Az070U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cea2cNNE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6886cd07673so316047b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490149; x=1729094949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGJVSpQBdEJnufx8hCONnOeuil0ovqsMOkm2dztukRI=;
        b=Cea2cNNESI+KsPNuy0EKjvFV1nZT8DwPXFvl9eaGQPW6xsPWiG4+WCL00zD4ues+BG
         +LbaegjmPedLyE038RMAtiwgMhjBA6NHLvJdiVUKc2Q1bfGjt6JH33rzR+2ruR60tGfA
         Cq/weGopehcSZuS0ZmUJj/VRwSlvbQyLnR6tC7L5pFVbV+4wsWEc0EbE8naM10QOiGtl
         D2BhdcMGfpQWOyf949WiopwvZGag41jU5I5VmlGz26Ba7WPEf8N1E0XD2Oyr8y7perSb
         1Pniz9ZDLXkMu6jYHeAuSu+c9VfNkVE/FWdvdrLqKHvEZCGs3DfbPsJHhjArO7PdKJEi
         cvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490149; x=1729094949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGJVSpQBdEJnufx8hCONnOeuil0ovqsMOkm2dztukRI=;
        b=N+VC1TwirDl4MqiX89EPGmfSsnbRvLGB9rn6extbcxjpfZ7eZeMCZNgLOIkvZq6OT1
         TqZMCbaJXHSvAgK4Vj7w5/3n26yNKT1jhE4m+CPiiNbtJrILJLib0iWxXTY5kuN3Ryd2
         SLpiQLmRv9JufkDYQSxpj6LpZI1qUp9z5Rd6Xs5sqZoWtkgjKIaXd8bcoHLqZl3xgYdd
         V0q+9qPiBdaYX44HM3yzLv5LkU2rf9ic9iTHKos99LGkErXfYbco1rJlAfuee2niBBlG
         5Dj0ynkVQrEjAMcSLVG4wgI/8sct/a/XnmYTnxjjJL1daNMpjZ0mQR4UUNFja2w9+vVW
         cf+A==
X-Gm-Message-State: AOJu0YyWnC1KQihe4NeJJLCyUnRm8FNnuN4LS9fe/aASncg/kcbvShcN
	neiU0EdUBSWR3Eha3lgAHjgySvLdy0fKS5tmeO2e/TFaEGQJWh+fTUVVIa+w6oMxH5GEgSNNnB3
	R37e5ep0yEEINGoas6dycdyLI7kQCVVwOIUhjuiQ/6V8lMTORDSJzTL8s3CTU5MYRzRAue2EAWk
	Suw6dnCZBIn9oZLzuRNrN8Z4LH0ec/Hg==
X-Google-Smtp-Source: AGHT+IGcrpMuY+JUdG2304e6zDFXCrIjHXd1oEUvOKqh9gm+2UjFx6EJkS5NZtUvSSlBsb3U+IRyhrgW
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5b:b86:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e28fe516b5amr2248276.8.1728490148421; Wed, 09 Oct 2024 09:09:08
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:04:41 +0200
In-Reply-To: <20241009160438.3884381-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=ardb@kernel.org;
 h=from:subject; bh=2aGbXNWak6ut+XUg0ikYbMbWC3UWCn0/S+aA/QUouf0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t5azmxVvPswZHXo+eZV99ILxaoHCZkO2ShWG1fzZfj
 dj+ce7DjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARy+2MDA/ZrgbNPbtsYlDP
 rOq9G7Q6V597L3Jqq9sCbs3/wpEGh5MYGb78MV6wNolJSO21T0+OoIGEyFzrXQ6zdnhMFmFb/nZ dCgcA
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009160438.3884381-9-ardb+git@google.com>
Subject: [PATCH v3 2/5] x86/pvh: Use correct size value in GDT descriptor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The limit field in a GDT descriptor is an inclusive bound, and therefore
one less than the size of the covered range.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index ce4fd8d33da4..5a196fb3ebd8 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -224,7 +224,7 @@ SYM_CODE_END(pvh_start_xen)
 	.section ".init.data","aw"
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
-	.word gdt_end - gdt_start
+	.word gdt_end - gdt_start - 1
 	.long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
 	.word 0
 SYM_DATA_END(gdt)
-- 
2.47.0.rc0.187.ge670bccf7e-goog


