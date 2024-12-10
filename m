Return-Path: <linux-kernel+bounces-439747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C889EB379
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68691163EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6D1B0F12;
	Tue, 10 Dec 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZEEh7+J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33861B423F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841292; cv=none; b=lp7+RxA76ljOtKREcaRlnCF+XVty22kJMiulbrhAiXh8UOP44NS5EdizfkZw6VpIjJYeTl31wcZO0TBOA97OCXoUB9oUo0nAl37I4VmHUPeFXdZvyS/PX3SMi97TbhB/P0nuKknZ2vn2RvL8EgDM7c9atZXwUEib26JpwBaB+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841292; c=relaxed/simple;
	bh=hKVfthvsa17ETqwzM+IPunkLwW1BQ0tuuiDhl+vst78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0Go1odDxW5K8+j9xYse/LEl6H7ranUvvfUCR9C8bnEU9BnZ8uE+qdI3I1cVv+oFH3wwloMe3Qu97NaQp1z2Z3+GtH9Zl3PALuWqh1yW7rU42LPvUzuTp0bmi9vWUw77XauM93wlXg7iiek7Kq18Ajs6M8ln5ugmO76E8RA3oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZEEh7+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkig53CpkMCs8xZ5GQefN+G8yQyR6/dGUcen+HDOvno=;
	b=gZEEh7+JNpszVJeiXDvUWkw289uAThgIFDHovDG0w0Oec2rVDiI0RSwIZFAv5L1rTLHFrs
	TB9emdwq/e9xPzW5xh5afKr/n8Sb9N5O+yJzFJr1DmZD+1rQn89hQHpLMkrpgh6Hf30mS0
	ogoIT1udRY52i9iEZzmky1EC8mH5myE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-mBcxx-3nMPKYOyIVQ6krPQ-1; Tue, 10 Dec 2024 09:34:48 -0500
X-MC-Unique: mBcxx-3nMPKYOyIVQ6krPQ-1
X-Mimecast-MFC-AGG-ID: mBcxx-3nMPKYOyIVQ6krPQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d889fd0fd6so103892566d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841288; x=1734446088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkig53CpkMCs8xZ5GQefN+G8yQyR6/dGUcen+HDOvno=;
        b=FPLJWuTPHohLBYVGeZ6H96ogaM/8uzQ4BGQ4BUKAjlDCl6djoM/gXylEs+aSzX1bqc
         XRwkvJmq3RKXBiyxZELpgGbvLRVYfHr4rQoXrwbjaz6xP3f5wqK4lz19wbf9rX8CWQdO
         yipyxbj/+FwVXf8s+yBDLVqm078zPbsq9Hk9d+jaxy5nBD9K4Sk8S312OW4gSAPgqEn7
         rxT0Y0bYoX/Lvfk5He/YsvyvBoVPd/suztMUaz6PACc29a8jAL+1GByMRf9+k0BNANWi
         tTxNCeu6MMh0BtXWFxdKwjTvy1odCPH/n5SB0Mky4biR5Nh3dejzB6HobqHh25+u0ykk
         F2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNshLWwn2Zv7kJbxKgCRcpUDSrzXwNA6GnS4/S5veFoPYcrv2yj1rRF6514P0DPkW5KNIKLYz3rYCP09Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TsL8l0BHT+VEVsFOWNDWWvbVAu9r+LgE6aoashO7QTTxg6SU
	bGJjEq3sNLfBM254nfXGySr+HV5+9sQ+SHzYRyVcEujaIsIuDxF2qftmhkMsWZkY0th+9R9+WQz
	XEfkRQc6qfvq6TckdOVu4Fpo74en5xGfSU1orQ7wlpY6NYdZvjPc74lkM+GfPyQ==
X-Gm-Gg: ASbGncsu/p0vkA75F0LUogISK+cXnEOnamCpghul9H1yPL5VPtBqxTuUK/e8PfNArT8
	M9pIvoyiKGik/s9xkfZdflndht6lSqxGc/qsl7NbTj/KA04wOx3JwILZxSaqPXtGyAdCwSoQfb0
	RCAlGlo0Xop/yJ/HM4jb1m9i7szhW9Yeql5HaR5fqGWM3XOwSAvxuxNC3Ca8veBdn3WJMIH2Cct
	IiJxco3f+fq2BTqTBl3aopbuXPxb3DO93AdptH2N3HLQZT+B3imH3/p5VKUQ3NCEaPHl1L+sMYw
	oSjvXdhETZ3hnWfTL8veX6XRgsJ0BEs=
X-Received: by 2002:a05:6214:5087:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6d9213ba859mr65685736d6.20.1733841288288;
        Tue, 10 Dec 2024 06:34:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSop28FY6IektnPFRQjQ8gA1PitVY9Yf0WUJf69W1zgtjztC/5xoivV4T26/rVtmO6MIg6TA==
X-Received: by 2002:a05:6214:5087:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6d9213ba859mr65685226d6.20.1733841287948;
        Tue, 10 Dec 2024 06:34:47 -0800 (PST)
Received: from step1.redhat.com (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dac1434esm60163516d6.124.2024.12.10.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:46 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/3] x86/sev: add SVSM call macros for the vTPM protocol
Date: Tue, 10 Dec 2024 15:34:22 +0100
Message-ID: <20241210143423.101774-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210143423.101774-1-sgarzare@redhat.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macros for SVSM_VTPM_QUERY and SVSM_VTPM_CMD calls as defined
in the "Secure VM Service Module for SEV-SNP Guests"
Publication # 58019 Revision: 1.00

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/include/asm/sev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 91f08af31078..97dcc8d938a6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -365,6 +365,10 @@ struct svsm_call {
 #define SVSM_ATTEST_SERVICES		0
 #define SVSM_ATTEST_SINGLE_SERVICE	1
 
+#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
+#define SVSM_VTPM_QUERY			0
+#define SVSM_VTPM_CMD			1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
-- 
2.47.1


