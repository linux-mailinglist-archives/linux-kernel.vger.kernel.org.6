Return-Path: <linux-kernel+bounces-573294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89CA6D54B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB22169D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E6257AD8;
	Mon, 24 Mar 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7pw4lje"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9D257448
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802093; cv=none; b=pdpDUIpTq0Y7UvcViSV/0pfe4tVZiQIuqCYljTtzEWvwtmGXUNukUpqD12BSQoM0MLt5pCaItWVzhivIoJhAumU+gfA+ck/E+tTaiHzOeiTsw2TznnbGargC2EK/HMVeezU34cw929Sk+qwx6Cw+UzYjuSNSfS9t61xD6MwlLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802093; c=relaxed/simple;
	bh=t9LuTuSgB7oSIWQS+74CbsdvDwfuBsZQt9ORVAh6Xmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBybfZLDNtjnxbLGz+RrQtqYTQFAsVexeN+EF8Cuw7KmVdJoQSTUAW3ksmy7zjGYf1MWH9/QTbhI0qvqU8I31y8w4Npz9/MTTQ29B6g4BljAzMPkMjrLJ3aVe8EgJ/p+Em+YvguLf6UVsNjVoTS5PhR2L7ejqoE3UvP41UHBpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7pw4lje; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so6547026a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802091; x=1743406891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=txguX40hwxFqsph9jZ0ZY6Gsn7G7EapqsYPb05Nyq5Q=;
        b=F7pw4ljeuoQHAhhfW6A0Ut4AXy7WNI0IRZlxxyOs+Aqwwp+eLM7KVwGO2tzE/wB9IZ
         nkibdzZKhyMB2tb1NC+BKu+f38ZhpFEl2buos21qw0j+68oPv1Ngpp9LVoientd/7gYr
         vl2q4Hu0e95GOdav1BKGKZLRqZ5Vyif4OHfxR5XsmtpxPL3Aqi+tXbEuT+w6eEWfO6cX
         qv55CEd2nJOzeDmh3F+qXvyPEmeHm2GVwPrW/DsY3Z5QNPqMX9M2VRREPdbNRr06HzVZ
         5NaAesqh7ht9bs/DjehM5Cue7H1MYOlt/cq+t5vlSUy5yBD/ltqb7pQ9O52+yMSnwqF1
         QVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802091; x=1743406891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txguX40hwxFqsph9jZ0ZY6Gsn7G7EapqsYPb05Nyq5Q=;
        b=XHFjIPQIPoVCAi3V+K2xZE6Jxah7UTSDl4WkDJoTBBIsoA3u7CCKx9VxIUBuJGCLbP
         timD7s24//1jHfmbw0V55GLr4PZbEksjnHYRFnHwOO6orglTjM5GozT99twfJbyNkTcV
         LNuXTsJS1qO3hFvjtCsPqSAC4hwNbld6A6OC+03Yunqhb2t8J2x00N8F89SOBqWz6Hyp
         RfdlWJrpv0H+4FfsLZXzm1RRKoWl9Vqv4dJwdDPkpPz5SgKmmVjySe1ytX/+wicT05Hl
         6YX3YfayxSYTbDkKczoxQmCaFAIArj0boD6apK5pY1kQhGBleIaDXYyBitLTaeYXHKMY
         vJOA==
X-Forwarded-Encrypted: i=1; AJvYcCWCZzyy8C829L9tdpXwY3mNTAY26WfwKcqvSl83xA8xH60YFd4cJ4n59PLouyKt58+6iuq740CZMmtCZ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxic1d0fjCQOLsFKixvdUI7mRwWuMff2ojaDrgclTG3+KJqDCy6
	TubGmxCPUNAksc9Mht6Dh1ml5sk8pEI7we1ic+N89rai45M42LMOVkg/3NqtaOhhc2KB2OrY0XU
	=
X-Gm-Gg: ASbGncutm3ruSeXpS5yvSeX3sLacp2v5HDe5CKdp3adJHCXHVfSYo39qhHHHOg6415j
	ziE/LGBn4z2s328+Wc6s11G3qVQwIV0tZwVGkdyAPrkWTeCxzUTAbhWRmJcDP0nz5NfFkJUy4P8
	3VfLREN+7sgil1AJX7QuuE+aStYX82wwmVbk/ph436NSjWqYbN7f9HfOLMtgi7q7OteMsXYgYFX
	L1DiC8XPDB77gjUVZHHTOph0xBX6eqT78tVD5/xrx/QxcY/SuAVye9kTkPZTmAjSI+vH5suogYP
	HHX0Oqs/fnN9FZAwmmkdCzfhVGAsTQ4gdDNxcPnYcpbeeakqtPNrqKYf
X-Google-Smtp-Source: AGHT+IEaSKdVHKBTcyVQUTB8pbjahi6HmIfbAfkDhwtDzh9LW/kbNeuedlIsscVIJH8s5eGwIkSKBQ==
X-Received: by 2002:a17:90a:e70d:b0:2ff:698d:ef7c with SMTP id 98e67ed59e1d1-3030ff230b5mr19236244a91.29.1742802091423;
        Mon, 24 Mar 2025 00:41:31 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61b34dsm11460804a91.30.2025.03.24.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:41:30 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:11:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com, quic_cang@quicinc.com, 
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V4 0/3] scsi: ufs-qcom: Enable Hibern8, MCQ, and Testbus
 registers Dump
Message-ID: <icdzzhtobv6i3pporxca3bf4j3stomni756vuonekdmne2uk4i@wfkk7egdajy5>
References: <20250319063043.15236-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319063043.15236-1-quic_mapa@quicinc.com>

On Wed, Mar 19, 2025 at 12:00:40PM +0530, Manish Pandey wrote:
> Adding support to enhance the debugging capabilities of the Qualcomm UFS
> Host Controller, including HW and SW Hibern8 counts, MCQ registers, and
> testbus registers dump.

Why are you sending next version without concluding the comments from previous
one? This is not going to help and just adds revisions churn.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

