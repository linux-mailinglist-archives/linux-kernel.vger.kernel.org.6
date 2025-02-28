Return-Path: <linux-kernel+bounces-539020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23779A49FED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933AA3AAEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160026F444;
	Fri, 28 Feb 2025 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbSWl/mV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE983281358
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762474; cv=none; b=GNVxF3By2mMcyGwxRHhY5ELwJZpknwo79NSxlrumF96LbOXN152Dc7IbcKj4tdScZE2ku1rUBR9g8u68qZXkBZxieK/HPlETGunppI7dp8YiuM+xSOLsj7F7Ju816h8QkWLF1dNTj4mbU7P9cIppfSpwenkbzh/o4lPbEACVz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762474; c=relaxed/simple;
	bh=UdkFdwGky8r8xX5xE/qH3AptQWC28byd36YcVlJKMHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJxsoYoMTwZN9GkXc4SKEEM6beAh9Enm8h4a/PFz31DsFXz2VrCwjjiTnPYDZVn/WTLMZKVy3WMk3AlguKLH9pAzKCmL9LQcgwwMpfOG9Qk4d9x5UMHlRPqm8yk5APDIgf6MI4E4+97UbCZAniUrnfdL8f/AVGyGfmLO5Bs+HkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbSWl/mV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8oGEg/h+TCiOvWbhbC4Zsf5+aY/ltLTYIAtq8932Y4=;
	b=MbSWl/mVDxTkx2HXVmSsjzp+2XzWxjsQvagry1++a2dAz7d3Xo8aRjl7vSSCseaX1PhVd0
	P2n7nAQxPUsuYPCwcyp3WNPKyMNzVt89ce4HYSoQXSCQ+4zozYgnthEnuIdjlXyXCobVAd
	TB3H1Ouq/Y6A0BKnpW6D2uOq6VwIZzs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-2qUm4zspPBCUM25_PdBXIg-1; Fri, 28 Feb 2025 12:07:50 -0500
X-MC-Unique: 2qUm4zspPBCUM25_PdBXIg-1
X-Mimecast-MFC-AGG-ID: 2qUm4zspPBCUM25_PdBXIg_1740762469
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f11e6fdbso418189f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762469; x=1741367269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8oGEg/h+TCiOvWbhbC4Zsf5+aY/ltLTYIAtq8932Y4=;
        b=bkS23yzlrGf03O/GtixvSuwFh5XCAcgGvY1gtvacgzYORn/P0cqIk1Bsq1MXO2P+vX
         48f1hMOvILZfBHrUyBjbvnGqSVK1IxZIihi+yoVKtZvpaKnKKDesVLRECn0HZGdqiy+S
         BtZaWm7QglKi7Jy6u06BAfYmjdJdtH8ehY4Tp4pSDthhkIvQ/017oMsy3nVlokyynVwd
         pIyozTg4NmrgvJtHkFy4mhVATDo/lXfzYcz7uDdGMKHBrmurrQXDim5NX8a66b8OgX72
         hUpMtKoGehm4GuY2CWxL3oZLdoBm7Trh0qPvgKplxyLq8jbJ7wQufkjvfW10BidAlRrw
         Qi/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/s9oZQiLpaBA2ultBPIe48pctK2fL0jQWIBkSWITKYI10WvXr4kMkF9c23u1gcZ7pG/D1Jct29fi90c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/to+XKO5c5hV+I3ZER1NaJH2FSg+rTqmVMJz/gNmnMyAs3/9
	kEzgICHTKzhwFsmSQwJCudFdaz2fEiNk67KR+C+Owp2YWt+dUZlymzX5vNd5RyMnYy5CCE9flBD
	5p24dXZxMAI1qtAVFtyf/mdihvxkl2YzWj9QkIyxLABRJHBA8PO4bYMw2CWQcew==
X-Gm-Gg: ASbGncs072nqUvGxeUcyFrM/c7xDbR2pU5xYFL9+csi5aNNusCfAWVDF/tv+hDoimCI
	+MBr5cYgqOVyd1SSe93ZpdwTev4+lZNBby/8JWByYHJGbKbmnFlEcM6wORqBKSfVjXCpT0E802e
	FVgazIabpqesP3/9+agclqYCYBHAMdsTQU96o5OzXnaH5IB5eDzdGnigvVGoCLuHYJWazVhuHjx
	PgQSC5g9I33kCvbEHzzSAXwVM70veG0ncAsEW2g5OhmAva/9kqMumkH0pm+ZE/LxZ9XpeQSDEP/
	8N7VUXNvxC+FMrNIS1As
X-Received: by 2002:a5d:64a6:0:b0:38f:503c:ad80 with SMTP id ffacd0b85a97d-390ec7c7039mr3336363f8f.5.1740762468725;
        Fri, 28 Feb 2025 09:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/Nxe6WMAVJwXXr/C1J+GuxrUo1O7QoMaasTUiuVrqT64txBIeDvvVO3zbdNEwK5gDuewOmA==
X-Received: by 2002:a5d:64a6:0:b0:38f:503c:ad80 with SMTP id ffacd0b85a97d-390ec7c7039mr3336286f8f.5.1740762467958;
        Fri, 28 Feb 2025 09:07:47 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm98667785e9.26.2025.02.28.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:45 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Date: Fri, 28 Feb 2025 18:07:17 +0100
Message-ID: <20250228170720.144739-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer.

To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
chip's flags to get recv() to be called immediately after send() in
tpm_try_transmit().

Instead of abusing TPM_CHIP_FLAG_IRQ, introduce a new callback
send_recv(). If that callback is defined, it is called in
tpm_try_transmit() to send the command and receive the response on
the same buffer in a single call.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/tpm.h              | 2 ++
 drivers/char/tpm/tpm-interface.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..2ede8e0592d3 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -88,6 +88,8 @@ struct tpm_class_ops {
 	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
 	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
 	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
+	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
+			 size_t to_send);
 	void (*cancel) (struct tpm_chip *chip);
 	u8 (*status) (struct tpm_chip *chip);
 	void (*update_timeouts)(struct tpm_chip *chip,
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b1daa0d7b341..4f92b0477696 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -82,6 +82,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return -E2BIG;
 	}
 
+	if (chip->ops->send_recv)
+		goto out_recv;
+
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
@@ -123,7 +126,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	return -ETIME;
 
 out_recv:
-	len = chip->ops->recv(chip, buf, bufsiz);
+	if (chip->ops->send_recv)
+		len = chip->ops->send_recv(chip, buf, bufsiz, count);
+	else
+		len = chip->ops->recv(chip, buf, bufsiz);
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
-- 
2.48.1


