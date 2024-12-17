Return-Path: <linux-kernel+bounces-448837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758829F4640
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C66916E3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183A1DDA35;
	Tue, 17 Dec 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGpkFEJq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329B1DD54C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424963; cv=none; b=gaqLX4Pg1/Z77OwXmerPLT3LfJweUNsd/eFWrM1VmNoOQ9v88spDHb1nXN4N8wnL3WlfJ0+yB6jPGDAVq5RiiZAogzCdOPTwwZ/PPEg2d6rtkOMVNnDzFC8aJqUc9/O7dp3pzBAaEtaORChspETh/pbYys2Qft4wpI8dCDSgFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424963; c=relaxed/simple;
	bh=u7EPmGjE3yItsH3s2qUAg0PSaWW2yPqZNBMhA+bEKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EB+hU7vq2g8vIwZ9n/C2zyAmjD9m5hbQ9Js4sQ3DFHSIE2tYnKsB0ZRI4jR/IVcyeOg5nfYxsK992v5pjK09dRuOtwdGHk6I1WAWVSg9kA3mIEds4jd/c87xyuV/jQMb/699VY5ETIdxE/mmjocAJTCb8gV/seK3MvoLaes++2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGpkFEJq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa696d3901bso971650066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734424960; x=1735029760; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnqCM9bJQbzW+r23KYKuk+z7W7vSJuDPcGSAWqztZTM=;
        b=eGpkFEJqAFoWZIrxDV9n/X6TF3HfhEccD+aZUuL0zvMyvVkRJt4qf9I8gpTeb66dyu
         /0QtCtdWPyfaJMmz+MxgJSddgH8Dj0ibNaBPjIuG25XpRDQIZ2O9y1fba5kUM3nSbx2D
         J1piuAaPYWo0liGBhhors63POmBlKR3wmQcc42B/JKN/nJsnJ10U6TlaPPFzkAAEsNYY
         NyTNMC3z16xqlGl/8xtb8MwYtQmXRoM48TvV5IaHWPGQV6wJ4mTvaB/HXhKYvOZoLYrT
         PKzEj4NrTLMW/BKi1gLrgN3s4+T7KG1W6Vq8t3ZNj7YK/vWuLtgYuJ0WrwAYQTVkXFVU
         IyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424960; x=1735029760;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnqCM9bJQbzW+r23KYKuk+z7W7vSJuDPcGSAWqztZTM=;
        b=KBTHlgJSj9P35B5SoW0IJflQ+3CiFu5k1pfFW9yNMYSE4HR/JAtat5NBb7RTZ4LLxm
         l8LI+XhkNH2/0gDrAfinKFBz56fy1sEChTKmMUbAzXvKYhLQEes3rG79FW2qW/IUKfLA
         Vnskzd1mbvKBFHlq0uiUR72+kjoo2R9pLY2Hx0Tcw8qZxua3X2lUz7nAu+aIjP1xCDN+
         HXaH7HibarV2an0dHJplfi2ZyOjpsPWr/8DguK9xrPU6LN6+7zBrliGmF1MQWVQPgfaI
         Zc+or9KYyeqQ30tCA4+XA7xyRW4Nwp367C2zJOSqFFfJsiAHBTvQfKsbSL3x53AXyaS7
         Jevw==
X-Forwarded-Encrypted: i=1; AJvYcCV1aAiAY4UoSwCP38eJ7qXV4+9lfDXD3zzFbPOdhWYUdBNDiEAwBMeTVoYzqfYLA7puk7YP9P9IwH/cKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX37xBIaNMM2RtrC2Jaw5wFK18eoUS/kKPZj0lfUKUiKHBGdhd
	xmHXP56ArZFDDlddZFfY4HKkfuKbJs6EdCDT3V8yPs9WtsM6i1h0rCg8WowhnfM=
X-Gm-Gg: ASbGncsaM2GqFgB4VuEMONzJFca4fmepnI1LQ0zOn2jfwvkj6jJfttblbSvyQVzFXI6
	eEuYGwrW4AANPaZvUb3sJrw/JVXxmdQc7YvzTAz/mrpHFpSUKs316tn+arI3pJwRqrDh+/eWfYh
	IPsodMmshNEmGwidQu7QvgzgpXTbrATeJKnPSMANO6+sTjwiHyfCPNeBms1oyxYHkA+GB78rUPs
	7DCEUafYjXyYAQJ15ap6FgDvzQS19oIJpJ5Vw6Gt58L7MkXivKc5n2mlPQkhg==
X-Google-Smtp-Source: AGHT+IHjl62rxv5fN8b6+l4bXJbQs4Ut+f08oUNXA0w2flv8RIt0l6xa6LQUMYsprZnWOdR6xiO0iQ==
X-Received: by 2002:a17:906:4788:b0:aa6:93c4:c68f with SMTP id a640c23a62f3a-aab7792d8bfmr1536349166b.21.1734424960284;
        Tue, 17 Dec 2024 00:42:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96087424sm415709366b.83.2024.12.17.00.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:42:39 -0800 (PST)
Date: Tue, 17 Dec 2024 11:42:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] xfrm: prevent some integer overflows in verify_ functions
Message-ID: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The xfrm_alg_len() type functions take the alg->alg_key_len which
is the length in bits and converts it to bytes and add it to
sizeof(*alg).

	return sizeof(*alg) + ((alg->alg_key_len + 7) / 8);

The alg->alg_key_len is type unsigned int.  That means that if we pick
an ->alg_key_len which is greater than "UINT_MAX - 7" it leads to an
integer overflow and the key length is treated as zero.  The result
is that xfrm_alg_len() function will return "sizeof(*alg) + 0".

However, so far as I can see this does not cause a problem.  All the
places which use this length consistently do the same conversion.  The
type of thing I was looking for would be code which uses partial keys
or code which uses a different type instead of u32 for ->alg_key_len.
I didn't find anything like that so I can't see a negative impact from
this bug.  Still fixing it is the right thing to do.

Fixes: 31c26852cb2a ("[IPSEC]: Verify key payload in verify_one_algo")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..686c6a24d92b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -45,6 +45,10 @@ static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type,
 		return 0;
 
 	algp = nla_data(rt);
+	if (algp->alg_key_len > INT_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid AUTH/CRYPT/COMP key length");
+		return -EINVAL;
+	}
 	if (nla_len(rt) < (int)xfrm_alg_len(algp)) {
 		NL_SET_ERR_MSG(extack, "Invalid AUTH/CRYPT/COMP attribute length");
 		return -EINVAL;
@@ -75,6 +79,10 @@ static int verify_auth_trunc(struct nlattr **attrs,
 		return 0;
 
 	algp = nla_data(rt);
+	if (algp->alg_key_len > INT_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid AUTH_TRUNC key length");
+		return -EINVAL;
+	}
 	if (nla_len(rt) < (int)xfrm_alg_auth_len(algp)) {
 		NL_SET_ERR_MSG(extack, "Invalid AUTH_TRUNC attribute length");
 		return -EINVAL;
@@ -93,6 +101,10 @@ static int verify_aead(struct nlattr **attrs, struct netlink_ext_ack *extack)
 		return 0;
 
 	algp = nla_data(rt);
+	if (algp->alg_key_len > INT_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid AEAD key length");
+		return -EINVAL;
+	}
 	if (nla_len(rt) < (int)aead_len(algp)) {
 		NL_SET_ERR_MSG(extack, "Invalid AEAD attribute length");
 		return -EINVAL;
-- 
2.45.2


