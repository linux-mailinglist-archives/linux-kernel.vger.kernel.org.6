Return-Path: <linux-kernel+bounces-339421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C011C9864DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AF21C2140D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E74DA04;
	Wed, 25 Sep 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdCU3z9q"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F31DDC5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281879; cv=none; b=ZpmkDzYDB8XVaHazRpbE/MYjiTyrh/uQzTQXVJ8/9E8PnGcIPUWpwDTuVTHxj14GAlqWJ2VJM0oXqJUdu1B3KOo8S0KnRUvx1RzCQRe1u3It6RftTO3xsJrix/htpMvgGuIfja1x2XUnps/PNJWNKmrsvnjGl+ps757BNtmBIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281879; c=relaxed/simple;
	bh=uWKo7zRK/Xmqx0Cq/oLyPS+UkQg7iz02ZLA2k1+FPBE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=sr43sBjquYa0PPLGv86inbj+9ILEM1myMzDhGHRer6ScV0pwDFYd6qB6gNVNALfCgrEppz7fbEQPIeVe5jZodtymKnupauxExJfG7VSLrAKuObPi5u6u5cQiM4rcYGhfSDR61Z4owGnGw9P3OnbAiEPNiXeQ/cVkI3C4z9EGFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TdCU3z9q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a706236bfso3339966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727281876; x=1727886676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP50uSWjV+hJIxa6UNz8iFm87kac5ssUVDTap0zM3Fw=;
        b=TdCU3z9q8W0aPIWmts6ByTFrn0exDAIxEyuhg5UGWlhVe5hdF9Z885VPGKfCrL2Eq4
         dzIX/OipaoduyvD0IqDTWNjO48yqzv9hLYxh/U0WPytzKwj4eKBiridm3PIs/Y/0t2Iz
         L+294lLSgXpKXv1Vsg7Rht7eI3kwNMUflRaaKkpYlED6zxQqCeO5F986SmYmYqGwm82a
         ZJoFolezMVcuISkytHXotqatSdF6ZQzBbK/GMreJNHHlBKd2mI5aeNXzOLGcmZd1nPIo
         h15Uz+m0591YkDKeQgSTHvzPQ7OrWVNDkR3N0pvDdCTWzTIxnvTBXbtqBHBUKg25E7oi
         TDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281876; x=1727886676;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eP50uSWjV+hJIxa6UNz8iFm87kac5ssUVDTap0zM3Fw=;
        b=cn+BIV1BpklzT1l/DfubAUPZt797ZMLZ4/H30Ymhbz++T/kRPVTS0TIs5M5dsbG0nD
         B7qYUyJIPI/NuCNPatA/4LOPCSXE0eNRUo3qrxdjn7+oKqUYmI/RLRNFw1kHtgx6/X4c
         KgXzfyBM9mH3p4fquAkiUFj44xKzbmPibK5g2WIeNa2sduiC4f7P4C1sMDlmlJ+erUpe
         3YT/g6RI+AQGvKHs3M4Z06evRgZvUw6r9j3PDSbHMttykkNXIOKVcLvHrVAA4l9PIJVd
         POFGlUn9cIjTqAPfzCNoJC5T5oKRUjifE4J5itKorZfztuenfieMeERx+Gcf6Vb7Wstg
         wU7Q==
X-Gm-Message-State: AOJu0YziFY32X1ZjoEzzg2CLRYHH/JrNNshZL4CVsYwn+IJkQA64NvJ4
	u+GmPxhcliiywD9JyOyosV2jyTCoh5X6vlpzSNhlryUmLIpyR4S6talwA4S4ajqnIF61Hs6nq14
	FBI8=
X-Google-Smtp-Source: AGHT+IGmxegFNIY1ldIAhp9rFEaHzPfraX1h4OI0uqEN5qAoT9hzjyowvJ4r+TpycZKIzMlnDaSIlA==
X-Received: by 2002:a05:6402:2185:b0:5c4:64e6:55a4 with SMTP id 4fb4d7f45d1cf-5c7206211afmr4368783a12.12.1727281876000;
        Wed, 25 Sep 2024 09:31:16 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c877a6c985sm32933a12.80.2024.09.25.09.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:31:15 -0700 (PDT)
Message-ID: <e4a03e2b-63e1-4247-a57e-10bcb75cf7ac@linaro.org>
Date: Wed, 25 Sep 2024 17:31:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 "Signed-off-by: Stephen Rothwell" <sfr@canb.auug.org.au>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: b4 commit in -next breaks b4 on next
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey.

On commit 2b7275670032a98cba266bd1b8905f755b3e650f (HEAD -> 
b4/master-24-11-25-ov08x40, tag: next-20240925, linux-next/master)

exists

commit 3a904d2c771115154380caaae7ffaaf0095fb88f
Author: Benjamin Tissoires <bentiss@kernel.org>
Date:   Fri Jul 5 14:07:06 2024 +0200

     HID: fix for amples in for-6.11/bpf

     To: Jiri Kosina <jikos@kernel.org>
     Cc: linux-input@vger.kernel.org
     Cc: linux-kernel@vger.kernel.org
     Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

     ---
     Changes in v2:
     - EDITME: describe what is new in this series revision.
     - EDITME: use bulletpoints and terse descriptions.
     - Link to v1: 
https://lore.kernel.org/r/20240705-for-6-11-bpf-v1-1-1960e3165c9e@kernel.org



     --- b4-submit-tracking ---
     # This section is used internally by b4 prep for tracking purposes.
     {
       "series": {
         "revision": 2,
         "change-id": "20240705-for-6-11-bpf-a349efc08df8",
         "prefixes": [],
         "history": {
           "v1": [
             "20240705-for-6-11-bpf-v1-1-1960e3165c9e@kernel.org"
           ]
         }
       }
     }

Which means if you run "b4 prep --edit-cover" that is used as the base 
for your b4 series.

You can't revert 3a904d2c771115154380caaae7ffaaf0095fb88f so you 
basically can't use -next for b4 at the moment.

---
bod

