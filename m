Return-Path: <linux-kernel+bounces-557862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D767CA5DEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734DB189CB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64D248893;
	Wed, 12 Mar 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7RmboZ1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A0198E8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789077; cv=none; b=TmbRFQLKJeD2XDbmcJTqYpngaybZoqtpIvHmi/iaLmM5nVD5DjyNs3bNrzMgEH6uW6FEh3+4zOzG7jYxbo06iapj6c1IG5nthiFNpRUr2dfk42leD2YE9ENv7UvUx+hatAWMn+HToDMXFbNJnOQfjMP33GwW5xyRz6cWTZauvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789077; c=relaxed/simple;
	bh=59vSPNLq308aNbGzPWeKYH+js+aGLI09H1cADT2/MS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDMC8mk/bTc++DdochK1M/tgNLZaJewRlak1flSrm9bIhAIuoIOnHigTb8XHdqZ9HkNj1GwOPTcxAXPDBpp+vTWQX/pAXFLapHKPArpll+vkHY0urIcwqtaNmkilAp/BHcAhplU7PNbfxCSsCULuYRRhDlTL669rtXfnqJ+2SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7RmboZ1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab771575040so181683366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741789074; x=1742393874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59vSPNLq308aNbGzPWeKYH+js+aGLI09H1cADT2/MS4=;
        b=B7RmboZ1B6qD4A3LdelIpuk454SEmnXjk5A/8LHlJziBME5ThgzX4itdQ6W+K6Cq8J
         gy4HMbV5YhsUkmtA4H6NmjA4yCnfTwk1aoI2puNxVjXuBHlIAvC1QPT2X2iTYJLoTRn4
         HkBakbK4qL71eMk+8LcF3sUtE4x/NwKR6FfwqASpy6bim3UU9fhLE74cX2lLFuYsih1D
         qYx+8LrqWDNGZOgnafz6xHaSXKBV8vV9Na7i3ICV9oiQCMXYnZoADYwnOgfPztwlZnl0
         jIkbsDJ5Hm7v7pbFXyxwVd4LdlXup2tFsibiVj5SjTyfleGQxv5Sa9LE7hGclX6NV5TB
         CmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789074; x=1742393874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59vSPNLq308aNbGzPWeKYH+js+aGLI09H1cADT2/MS4=;
        b=GU4ZVnxbnHo/fx1RTf6dgpXbGqcJNNTOk4zWTC8MlcLPExVzPLyOISP40D96zsjeGa
         ykyrHzlfvji0sX34lZONgC53NcnYo06uvdLADmje7vwi+WoI5gCnrNZv+igU5nIaTi9J
         JVB1qxJppZJY2V7VDx0MJpiwpwhDLXW87HtMtUmbvZ7ECnknPgGr7Fe7u4I+PzrueuS5
         sEdV2vrpvuNikkB/qJ3zFYM1h5RFWc+ukxzle2Lk4AeSkvxrhfeNBCWyk37XoqmG901l
         XnkhlCTxzKS7o62RihOXc82TMv799cRCPLSPEhqcOOScE/hN3cnjTNq+EuMHt8k6jsGx
         lmPw==
X-Forwarded-Encrypted: i=1; AJvYcCV6DtF7DQfs3CnmCyfgpeKb4mNz6/GmXZO31pNqje7QtMTZU5jnIFrPz6q1d3xdc41FhCXWGb8KQPJWDjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyaxuj05H52GikFLqo64qMcUeabECwzKBYGmQLLAf53Z4VNFmf
	bpiTODkoCgT1nPJDz0Hlysyp+82tmwMIhIAMRxAwkt+NypPe5PXt
X-Gm-Gg: ASbGncv04+V+zSvhbAQgNNm5w/lOf/EP5s+lslz029+vP5WZozKf58dcmjqby2MOcTz
	mp1IpaVQ0buoicNTAR2EI9nw4PAc2lmy796WetFS3kjH2iNF/R4UQhtxMW+6y5I98PEpUNBJf67
	z2XtSO8moJHFEtAG3B5iEiR4RkoXjXuzQuMivFtGJ1A6k054mnUe+QWKMjPkrU8/c2OgZzbs4Ji
	tWHi8LcUb6JJ1QV0e+g+jbqmwAED5KZEDq5//jibrya60mwfko7pZjz1w5ASBF3OAWWyNRgzYX8
	pi9xwH4bLDBZbWZtQcpZ9or+6Otiq2WQxpmHmzsXZ6uQLAhy5lqX
X-Google-Smtp-Source: AGHT+IHF8jx5vstYtsV2pEXC2X3/PEa+0XR1UF2mXA9eUosDbBGZ4jplSq4pv81t+MR3k9khbTVqxQ==
X-Received: by 2002:a17:907:3e8c:b0:ac1:da09:5d3e with SMTP id a640c23a62f3a-ac2ba4e2200mr1088240966b.12.1741789074048;
        Wed, 12 Mar 2025 07:17:54 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485bf3sm1094079566b.63.2025.03.12.07.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 07:17:53 -0700 (PDT)
Message-ID: <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com>
Date: Wed, 12 Mar 2025 15:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to
 v1.4.0
To: naresh.solanki@9elements.com, openembedded-devel@lists.openembedded.org,
 linux-kernel@vger.kernel.org
Cc: "Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
References: <20250312111915.2970032-1-naresh.solanki@9elements.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250312111915.2970032-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.03.25 12:19, Naresh Solanki via lists.openembedded.org wrote:
> -Upstream-Status: Submitted [https://review.coreboot.org/c/flashrom/+/51960]
> -Signed-off-by: Khem Raj <raj.khem@gmail.com>
> -Change-Id: I55c4e8529d36f0850dd56441c3fb8602c5d889fd
> +Upstream-Status: Inactive-Upstream
Is that really the case? I mean it is just being updated to a new
version, it doesn't look that inactive. That PR seems to be abandoned by
the submitter at the first superficial sight, is this not the case?
> +
> +EXTRA_OEMESON="-Dbash_completion=disabled -Dtests=disabled"
Nitpick: Could you please fix the whitespaces around the equal sign?


