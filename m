Return-Path: <linux-kernel+bounces-218321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740C490BC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5CA286873
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7D1991D5;
	Mon, 17 Jun 2024 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kjGXkdG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265179CE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658281; cv=none; b=NGdSwQ0t5IFfw1EeTeOtX0ywvTdhERegdaxuDrMO8QYHPKYo3NxNL//5vru3cE5GShfcqUQFrIXb/ZZcCIzX2GZfkk1eCc+bnq+HbnFnflxZXR8UuSzQ+tnov0/N4xVQSmRd74eXEvOpKo2yywNOGjZmuutP9CPFmHuiw0UDUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658281; c=relaxed/simple;
	bh=pWJnLgQ5CyW7zdyYTbIpYYJQXPj4mpodnqaGmD0G+z8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F5oAxQRff0ms2Y4ldArMfaNAAvOkW2TcIeAeu5wL0Ni2d377NORj7nGxztNzuf+gZXkbfkuNDMOxPIVzyOH9mfMmb84TLnTRgXPWUIkKnb8LzM9+gmcjVreutMVynPGZjKnsMUOPJZCYOEEfCgdZiJeevy5DwxHmwFPs4VLyMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kjGXkdG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso2094177276.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718658278; x=1719263078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqQQg4n2wGinehpZTbiRbcgjjNuzB3R0zyfs+mZXtRQ=;
        b=4kjGXkdGHmTG9f0D8HCELfMV3a5+xFf14Hq7RqM9j7Xma7ZA4EpGNglcDn5LZnNzon
         7Yoi0p/MKTrtKN84cqw87JsNm8pXKJXnUWOZ7KN9urjn7xMVrD7KkxJfi2hgkCHInlRr
         vXQAtpvu2RqhVWgdrcjuAyZs45uLm6SbG+zJEaWCXPdel1YYnmzVy9E/dt00bvhv4VM4
         QFt6SnCTczGJuKLuTjdErP8bQibvT09VGsO9cbwDY01qS9v2dUiGQE3Ek8+d/FW/Ee/S
         fgsvXAD608LkNhYCEMx9Nsl+wSrYcWFOrixQUyhvC9xNTtlminOelvWBHGpWBB4Kn0pP
         99hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718658278; x=1719263078;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqQQg4n2wGinehpZTbiRbcgjjNuzB3R0zyfs+mZXtRQ=;
        b=nV/Nb6dZs3em0D55ArWftCnx9iZZZdF+CFovEIAiY0gYH5bNC6Aym1nk4iiKeSg8iB
         2Ptwdd+/kxPHudcd3UNmddi+lS48c1PNBiokt8cJJkisjLTGteiWh3mCQcCmSJSAvINn
         P3mMBHJniGQ+ScPnrCaVh7p6V9F/43UD8gvElZT3FvAMJzksq/pLlkNAaMPjU7ZnHFBI
         TwSbeby7TojAEyol16FYkaWkecd7xu903mhJ3z1xj+d8UlFkyVKiI2ECQogL43tGjdAZ
         /+eBvDV+gB+lYN7UpYovU1JlWYSZeiNNH0idreGe+zZfc4bhrYhT76NSy1kbynWtzWlv
         VRzw==
X-Forwarded-Encrypted: i=1; AJvYcCVbiVXeLzivYzhUKWTlg6DqG0lp+yi9i0tVCZBauX3Y5UA+kqIYWt+yoV6dnOoJgz5o7CQPl/jffK0ZYJOTqnaiaRyT3fi1t30Tf4eZ
X-Gm-Message-State: AOJu0YwdP2FFYe6w4XLvLqp9t5XhZ4MMcZz8JXcK5rHJnrWUX1Pq758F
	59/fqjU6VP6MjHccac9v8X8B8UrGxln5yuyIQNp1XcmLGk0EoJhvj9TbPkK0QPQrpYcN6ymmuJa
	B2w==
X-Google-Smtp-Source: AGHT+IG7ZyviYZpzzZ4cpoc+Bjch9yUoULp2xMGjOCPRbyycuPImQP6j+8pMjyxrHbU9aZPoT8yi686MQHs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1142:b0:dfa:ff27:db9 with SMTP id
 3f1490d57ef6-e02227597bdmr167689276.5.1718658277746; Mon, 17 Jun 2024
 14:04:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 17 Jun 2024 14:04:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617210432.1642542-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: SVM: SEV-ES save area fix+cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

Fix a noinstr violation with allyesconfig builds due a missing __always_inline
on sev_es_host_save_area(), and tidy up related code.

Sean Christopherson (3):
  KVM: SVM: Force sev_es_host_save_area() to be inlined (for noinstr
    usage)
  KVM: SVM: Use sev_es_host_save_area() helper when initializing tsc_aux
  KVM: SVM: Use compound literal in lieu of __maybe_unused rdmsr() param

 arch/x86/kvm/svm/svm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)


base-commit: e4e9e1067138e5620cf0500c3e5f6ebfb9d322c8
-- 
2.45.2.627.g7a2c4fd464-goog


