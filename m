Return-Path: <linux-kernel+bounces-387225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575AF9B4E32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D96B25A51
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D72BAF9;
	Tue, 29 Oct 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOp7NZ7r"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3341957E2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216295; cv=none; b=jf52VVsUstlmAdQsJj+VRwzeYMUT27bUJ57s0zUMc+bvst+8Jymy5/oTQTguC9KWGfrGo1uMkr14B4C11SXBiDh5pCdFGN2WYGzEM+8DypJmiAcisDOgukP6475X22GsbpskyVcZIodab+kAp+Cr517Tq+LfletSJ2z6CwjpUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216295; c=relaxed/simple;
	bh=YHLDmib+eZ8UawZs6ZfI680Yz24c270Ch4GTYMJdQXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGn3cMbq7ytyc//xFqHsNiVDWIbx6JDu/ARa0SfRe3mZb92CMM1xzBgTvxJmMfGi/z4Yp7vIaZz96BF7SIKIL0Oy4X7Yx1UT4R/RK7XGiIkfdgYPStVxavXf77cPdUerzoFeMrOgblMLJ0g8T4y6tIgty95/eMT0O9O4ZQ6JfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOp7NZ7r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314c452180so45687425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730216292; x=1730821092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53QCQc6BiWikCOKUDNkwq9DudQdWIKRZwtdY6w3yTwI=;
        b=AOp7NZ7rZiY6zg+LefoeJopdK+cowZ+6IMMQ33NxMAxrniYu/CG70aqFuwh0O1Jrz2
         UMud7RPu4DPgsetT6aBejVuRnTCfJd4iRFPg+vc4nexAzoYBMrSxpKpQw+vhulIWPndN
         anThXjiW+eypcioYQoX0DUPU/OtAM0NY2TX73m93w3PjWaoHCM94t2k2W1t3VY1bW0ck
         4Ag/4aXQ2HUaR9X7pWx/qOqc718NdBTyp6FvuWWnK0jziZBBgj22lE7YLrdbC8oYfdeE
         azrtMFvR1bXgA9N5zI0AqvNuQ43Y4LAZFy+R/UO6EjUDpVk4pkq3urrrYcY6m0MRi0Mz
         79iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216292; x=1730821092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53QCQc6BiWikCOKUDNkwq9DudQdWIKRZwtdY6w3yTwI=;
        b=cDhb22H5xXFUpasETh8XOGJqPtVZepMHnnVm556pf8c8rUnTDFbZzKzEFbgCMeLrW2
         0Mxxym0gZt6jOG8Q5RnhSpCiVc+Fnn36OpTGlFG4xwQDdy3pDI1sqDq6PWFo3Y4B0hQ4
         0Pz4H9qoZX5mPQjCNvxFTyfCTNCuZzC/PY/36bTSYQGcEjFqnIdLKVB4Gi5gPEaXyl7g
         72M7gtY/LYSkIMhjwX2U2tAQmaMCGx3p21rwFiP/q1qnve2CE4c6p0Xjam/8Ov/rD0QR
         O+4kp1LlHuX2oA7rPvRnfkuhW1M29WFTCbDKymxtwfBHk+TKSbmkIuZy1dtI4WsBs+wT
         ucYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ndm19w6rVMc8kcfIRXPZphqAxPHNxrRpujsOL180Mrg4YYJ+5ZUzFLWVczOAsHscQ5vf0gxhBExaR4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPd/uuKjZc9eCCybqnIIoqkkjJ81UOAehE+htHJ3yPASQM8hM
	7iBjCboM0saky7/lhuvdTblpHyXeq2+SeMPLUMfHLibke3+VoIeJxl2KMOzNdNPS6EPxK+QxjmQ
	6GvI=
X-Google-Smtp-Source: AGHT+IHcVu4KU0PT4a0IR3Wnqd1e+lguJQKwgkSvqXryRFDzDnzQCdtMdahq/zbtiYKTbOjOp9nPBA==
X-Received: by 2002:a05:600c:3b9b:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-431b55f038bmr24259665e9.9.1730216292011;
        Tue, 29 Oct 2024 08:38:12 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360c0besm148103055e9.41.2024.10.29.08.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:38:11 -0700 (PDT)
Message-ID: <b177e736-e640-47ed-9f1e-ee65971dfc9c@linaro.org>
Date: Tue, 29 Oct 2024 15:38:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic: fix uninitialized value hdr_len
 and txbuf_len
To: Bjorn Andersson <andersson@kernel.org>, Rex Nie <rex.nie@jaguarmicro.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
References: <20241029021823.1978-1-rex.nie@jaguarmicro.com>
 <q5vuljnuhhasjbexc2aphfd3bzykz3v43sx2bb7vu5h5zacb4y@gvzbthmmg6wj>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <q5vuljnuhhasjbexc2aphfd3bzykz3v43sx2bb7vu5h5zacb4y@gvzbthmmg6wj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 15:28, Bjorn Andersson wrote:
>> +	unsigned int val, hdr_len = 0, txbuf_len = 0, txsize_len;
> This stops us from printing uninitialized values, but the error print is
> now containing misleading/false data instead.

Yes, the point of the error printout is to also give an indication of 
what data didn't transmit

         hdr_len = sizeof(msg->header);
         txbuf_len = pd_header_cnt_le(msg->header) * 4;

The default values of the header should probably just be latched @ the 
top of this routine.

We assume *msg contains valid data so instead of init to zero we should 
init as above.

Please do that for your V2 including

Fixes: a4422ff22142 (" usb: typec: qcom: Add Qualcomm PMIC Type-C driver")

---
bod

