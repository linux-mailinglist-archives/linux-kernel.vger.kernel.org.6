Return-Path: <linux-kernel+bounces-550760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80858A563C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE3118967A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69239206F30;
	Fri,  7 Mar 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jj5z5QL6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4371A5BBB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339735; cv=none; b=dtfKIkLsqxzIjtVKu7GY9ASNe9MJ13UrWa1JH31M/lSdTVacJbDysYf5hwUIMcbQ2RMKhBmqeVQS7yZMffFbgcULxKOmaD48p+7+fSZ3/93Dn83x0jjUZ/UvtpQu9tc5Kr7ChyZYzgXwRR2A907zoYhAKyhQBGzCsyyZvF7RGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339735; c=relaxed/simple;
	bh=6YeoeqWkwCNXJnRk/T6zgTx0/hcyWZyOla3rDPddU7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELommFuoRw4v2aIMIgZOMHKU46qjW7AmUVUlYOe0Nw0v4TuIm6b3AEy7GszQo9tM1noCn4GcPr0N09fR3L1Gn9zBgaiZqfGgaUVpqOe2l1iiorvQoGyy48eIEKlmd2kK909cV3VSnK5/RXa8Bsiy0Ih1dsFKxmBYzvNsfmmCi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jj5z5QL6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912c09bea5so1171685f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339732; x=1741944532; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ju5ZbvhcNx9BRsCMH0Wbm+2RjeifjUfGKt0f6VkL5g=;
        b=Jj5z5QL6M2VRGpNNaTVDfm1XFMK0VFQyB29azUW9wibYIS75kkjC7xiPKi+kLHW/hB
         iEuUtILRLlr0NXptIw2uYX1p5zuPrRgjv2ApLSzpd1kUmdE6opw+gHQ2A4N2Y/yW8lNe
         wfboyZoRzrPGADWwb5fIurUPHz/eOJCQStW+riumANjjhJz+105AC64W/dYFdSIpyCxm
         UL4La3YFPcgHJOLVHb0ZV6Ba2uTJT4S3nvwoZoVHifPADB5XQ+dR01COnhrr0Xwvb1cd
         Rw/0xwzW2EjxGObnEJzw+8GqBSVWgpIJL15883x9N/IlGuoz5/9NReGvbiS6gXgIp2e0
         RTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339732; x=1741944532;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ju5ZbvhcNx9BRsCMH0Wbm+2RjeifjUfGKt0f6VkL5g=;
        b=S4bDguTZFVnzlqHucbn2f/7AynyaNrsW0+2QYeDbQmII9MyxCC3xL5gZ9JJ83AzGJc
         926A61ehMv7VDGUc2Kqzwu7lk2Dkfn1vDn3qjcu9eT6K08oTtl5HgMWYtE19mdkAToHn
         gBheaRwK7xhwia7aDGjngRROqKy/YeL8PtbQXOBBVIJ1HFQ7R62U62K78ldMkb/223u6
         zqyIAt++54MuwDK2tJLI94NN1jD9MKOQvepETzQWIKgwu57EFSqwfKlBY6wD32k6ck2w
         zo4HTnwJC09Vv0Ii+NItG7DHGaa3uXXE3aG3fvt06hdFiIZ1lE0nCKDa1guMi2cTIFhI
         OQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPhRKx7dkoi03fyPZRJQIKcvL8RISNmW52QpCv2PK1EykwnXGrSyJg2W5UBK6Be2bWZ73A5I2L9/R50BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDyh99hcnkZIMzYHTZRxIYzDJIS2AjJ0JDNT1dw1+XMEYUETHP
	kQGrcvHwtl/B40cnUHcmixTcfzqQ6EqenUct+7XwxyoEufAKa3FkdcUpo2jnRHk=
X-Gm-Gg: ASbGncv7v6RWq6vrHHIMfNoYLBwXaVd9iwLSbQ8IqCvRlQqCdt1avV3+gFXkgehAd8D
	dOw0o28KdQLnaSuUFxcNNM14IxFgMBUizmzQu44LtDm/92V16pF7r0VL7y1QvCuY6Pg2iRda4Ca
	T1OX3zLkdUtge74aE0O1fgit3kNBlgmi5RbI3tWFiWaqrE70XiY/uYDJEg2KKGEi9tHU1SF8CuJ
	0akRhWbmVZsAbGXDY2zlvx+VmP9Ztw6VYqmttUEn8pYRpQr3Vl3QY4awG8nPkn7PG5XXmVNyc3c
	CO5cqGemD/OvKZfU+ZiqFCYJTeqIGQZBQfEDG3bDaOZgVOaEFw==
X-Google-Smtp-Source: AGHT+IHy9+4P7rIHGn06Z9Wnp3OaLVatH22AMmyNL2OvUFsznE8mxvWG+6gIV29lYBEOGpcOgyg8oA==
X-Received: by 2002:a05:6000:1844:b0:391:3110:de46 with SMTP id ffacd0b85a97d-39132d98a83mr1919691f8f.38.1741339732054;
        Fri, 07 Mar 2025 01:28:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8b0461sm47647725e9.4.2025.03.07.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:28:51 -0800 (PST)
Date: Fri, 7 Mar 2025 12:28:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] eth: fbnic: fix memory corruption in
 fbnic_tlv_attr_get_string()
Message-ID: <2791d4be-ade4-4e50-9b12-33307d8410f6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code is trying to ensure that the last byte of the buffer is a NUL
terminator.  However, the problem is that attr->value[] is an array of
__le32, not char, so it zeroes out 4 bytes way beyond the end of the
buffer.  Cast the buffer to char to address this.

Fixes: e5cf5107c9e4 ("eth: fbnic: Update fbnic_tlv_attr_get_string() to work like nla_strscpy()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
index d558d176e0df..517ed8b2f1cb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
@@ -261,7 +261,7 @@ ssize_t fbnic_tlv_attr_get_string(struct fbnic_tlv_msg *attr, char *dst,
 		return -E2BIG;
 
 	srclen = le16_to_cpu(attr->hdr.len) - sizeof(*attr);
-	if (srclen > 0 && attr->value[srclen - 1] == '\0')
+	if (srclen > 0 && ((char *)attr->value)[srclen - 1] == '\0')
 		srclen--;
 
 	if (srclen >= dstsize) {
-- 
2.47.2


