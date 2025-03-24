Return-Path: <linux-kernel+bounces-573529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A221A6D8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A437A27A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2A25DD03;
	Mon, 24 Mar 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2gRqq4x"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EC25C705
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813626; cv=none; b=uKZXbaeSKYwpLbbFpyZ3+K/Kd6NWomXH/cJTat2+G0REJG0QG3nFfAdaAgB1mioMro4xiO4mt6wUsDBGWbQRh6yEmkcfotOrSsVk//X+/QTAVx79vsO7ucj/Ycz4I0cdJEdVf3pQNfubYd71dWGffcJQV7uKwyYHX0XGnScSVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813626; c=relaxed/simple;
	bh=KjVsYB/6NbKNMWPMw7dJEN7gZajXIZf6BXVWnnRlI4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GpikAH40jzCoTzotnyw8x/g8sa6jeWF/0pTNjyYo5IOMQD2Y+6orerWUzRwYtUo69iGSeS6qcysCtGvwPlW4Pwa1uIkYRMielo30G6O7ZSbM0+G8AzX8BG2eAB8IQYsDi9G0XFy1wqsLvJmXSYNj0WLifPFyBaEONxWyYxnY59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2gRqq4x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-399676b7c41so2158324f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742813623; x=1743418423; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRBBC5Y50DbrnY2KR5VRMIecYWoom7fg1aMey6lzMKw=;
        b=u2gRqq4xM612zQdS3dWg6nQFyzVa10fpHoXTlO+kz3hITmqKAZlltof+qevYCZ1yxc
         DV7eFO3UBTRQPVJoJX5GctNElfwrB/8r1X1KTQZLK0gOkm7bckrrVzotx6dINS/XVwnZ
         SL38Bav8DEUU+4sfETBxHyFD6RnFeQU2NgogmtM45SvtDHtpVPlCUZ3BO21xaKS5v/ge
         AFimaf+puDTnpaAH7gamOUoRo8sU2bZoPZ979FRnhrJyxskeaPQTBEka7QWQmPkPXwrX
         socKWRgglXcGkyrVx74vBkV8gYLs1JDuyAyOXWrr1s6sl7m8TkdLdqOw7YQYQNGDIgfr
         n48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813623; x=1743418423;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRBBC5Y50DbrnY2KR5VRMIecYWoom7fg1aMey6lzMKw=;
        b=LCqNMdnwjYe3EOP6mx6IKiS623PcPfX/x34ITmWGevZGoVTx6vCtoY7rUFzgB+gktO
         GPErEX5mgF+GU/fjWvlsyGt+5POf3M/a0SBuOawtLFxlCLztMqAzeEv+WIYwGm7D+Omk
         GOTwGhZ9MiVd5uF5Cup3+KgtHWdOPYXMX/3XiUUJHuOTVYRWKrcQJDkQ0DX2mbzGPojo
         vokemmwuF2TgusAxGbt8JfP9C7QbJwd0w2glJ6hA/6VKwtW/dr53Zl95T9lXqYweqA60
         7fVFkyIA3zKx9/ORgr0jH41xzbpkDxF91dt93ol/ueOnF6NZR1v8/k/UYNvOh7oMMy5T
         F7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVFuWW2elg047uRPIJul7iKCkdx1+AZNsWP4TS6V+hu5YnfPcCg5qkPis4yLsxhEZqaMY+tA8FXfdMVvPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwjK9vz3smSdmUnkf5nbB0pXVRpmVSqcPR3XnBWnxnXshJwDB
	abhqGDptN18Le5S7DQO11EIZeQ3nBFika5S4eUNYUgXWCA6XhtcGAq+zu27jxBY=
X-Gm-Gg: ASbGncuhgPQHw3xWoZCa4lxSiz6MCYY799B0oCW87PqMrlecdVFhNImEXPbhifNu8zJ
	rLr1YyLO9RMdOOHgu9RIVPns+1JiCYaPzMABiU2A4dVcgv4NeN1h0Syx3bRS4Vs8m3u4vbkolk6
	tok6Svfa0iEYdi/GXQEimCS43MtqACUZ6D9tiye2nxHb3PwKwSjZUwJwlpx4JxRDIovxcfTOzLn
	CbK5vtpP32DEyjpgqWJjwgwZigZzbYjAsV0cJDXcdL8fLZATfxGfux0NFik75zvANHnJ5tsM9Rc
	Ge7wADtij+GzgRYgqleDr/a3L+YeOmtgDMn060epGD2Z4UZqbA==
X-Google-Smtp-Source: AGHT+IG6+X0RvQWAACJrJUGE18q5oXGZ8dddeugBl2ClpDLyua8TAmKdOcrERT6mZXU5Gy8dfa/gpw==
X-Received: by 2002:a5d:588b:0:b0:38d:de45:bf98 with SMTP id ffacd0b85a97d-3997f8ef175mr10199407f8f.8.1742813622782;
        Mon, 24 Mar 2025 03:53:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9b260fsm10435247f8f.43.2025.03.24.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:53:42 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:53:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: x86: clean up a return
Message-ID: <7604cbbf-15e6-45a8-afec-cf5be46c2924@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Returning a literal X86EMUL_CONTINUE is slightly clearer than returning
rc.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c734ec0d809b..3e963aeb839e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7998,7 +7998,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 		return rc;
 
 	if (!vcpu->mmio_nr_fragments)
-		return rc;
+		return X86EMUL_CONTINUE;
 
 	gpa = vcpu->mmio_fragments[0].gpa;
 
-- 
2.47.2


