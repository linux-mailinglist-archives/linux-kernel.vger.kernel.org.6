Return-Path: <linux-kernel+bounces-393338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD279B9F63
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1028B20B8D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AD517ADF7;
	Sat,  2 Nov 2024 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBQTjrbo"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55318175D54
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547529; cv=none; b=a5+z4Z7CovMjcVQub2SeyuDMJM2lweyMj7UUo26ZKQ0U/ubJ65wYxyOit+lZis9Ze+t1zsl6ELMffBH9ckeE11T1Zq3idL/lgQIFh06dHjJDdr7PutI0s9/kAffs7kpRMzNFfGiFGEeUQTBIrkwbNEwvlbqEsvVRmPkv/HnTj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547529; c=relaxed/simple;
	bh=2dIcYHUHHSHUxXdvGjqFxwDG3pY4LGa9o4b9agNpjm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l47dh+kXrJrfhVwRo90oDY2Vw/pLVO/qsdMp/S6SKFIEanpbDv/VJNDZZZkpkDn6mDRBYpxD5UMUa+9CX0jCrbNL1SRON87E+SnqU3C+PpV66ay0HnzEzTRS74cFKBk2jvFK+FL/6lwGQNdafEGNkL0OK4mYlIz30KNFWnuTPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBQTjrbo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso22043415e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730547526; x=1731152326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmDE2sdaLjNOs4aD8vxBNfz+8tHcw49VErx6rFxgu7k=;
        b=RBQTjrbohiKZNqIPQLkvjDUvkocb7TGdeYxgwzsQxpUQYkn+gu6q7rcRXMiqNR5c9o
         WFBjBx2t7RgRXE6Id0dZboLwTTGCT93nBScHvtUpHLmJFE98GqiCCaP023tobpVGZKtX
         v4diiuHlxRsLMxo1rLGKsgW8/bbFM1EW3/NE2sJCUXQ5nV6VB4L3TR/zXLb+UZ3aXUqZ
         9YCKqtUllhynoaO3+wY+jGNCOslPuGZGYWj5kFqT8M1PW/+m7U01PsfuKwsz06Jk/Nuc
         QKb0snsvIT8+g7BFS14erkNtAPE9+E4zuRYDEzo3XvYFW042wGXIKqLchWbATer1Iftz
         8Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547526; x=1731152326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmDE2sdaLjNOs4aD8vxBNfz+8tHcw49VErx6rFxgu7k=;
        b=jkLqlXo46r+ieF0xpg3XeZGp2vTbAcUS5fIs9fUICaOkrBrUmMXdNE+tnd81jwh0rb
         H+Q+042gZ3HCeTbFq1Bex40deitW9zPZ4FJOOqtavzBfVrhSBDEeL9xb2HbXIOY4YMfm
         VD6NhzgnP5yCfIYa487R56npDPmjwFqlp3kyGr+nepqZaOCB+ICUGEljFDznvRDzgvuX
         mhVf2vXYiZkeUzCnxDaxN+dINirnMBNJMx+pnB5kgZ+OUYgjytf8i03sNUzZtlHFwVl1
         fRWoyuHZkt/uxhjagxeicb9JwrxhJy/yB5OGCusfID6iySp46YUp+62ShMMJPFQ+Y0QM
         GLug==
X-Forwarded-Encrypted: i=1; AJvYcCVeItv6a8aLfq7BhcVntNFcedO5owxCfSlrn7lxqCB9fJQwKXcBQFrGTzYYP4XMG4pLRQl2LFWMyiLyfRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8gPpGePjcom5FNkLWSaQOGgPqArOyWKTfh8uJW7TP1qBUe2l
	0l3ARyQdUeu+KrI7LLX4hCYoUH82Q2desA9s9XQ0//n7EgK22AC/+p4n+6itq1k=
X-Google-Smtp-Source: AGHT+IHZgVCGFgEml8l2JE2qSNFWCtFv9ZqySVcQuZTYZQV4augsKxhgVOzAUHddOviPkYnNbJxEyg==
X-Received: by 2002:a05:600c:3515:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-4319aca52f4mr228460695e9.8.1730547525576;
        Sat, 02 Nov 2024 04:38:45 -0700 (PDT)
Received: from [192.168.0.35] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983ddsm93042935e9.44.2024.11.02.04.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 04:38:44 -0700 (PDT)
Message-ID: <787ae421-0df0-45ae-bc3f-762ad73b8216@linaro.org>
Date: Sat, 2 Nov 2024 11:38:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 Add cma heap for libcamera softisp support
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Rob Clark <robdclark@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Depeng Shao <quic_depengs@quicinc.com>,
 Vikram Sharma <quic_vikramsa@quicinc.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
 <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-6-cdff2f1a5792@linaro.org>
 <CAF6AEGu_qJYV3TnprJsqsWV_GoLhiBFQ8LNwfYDjczDparvZCA@mail.gmail.com>
 <173047431366.2974136.175546053701391124@ping.linuxembedded.co.uk>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <173047431366.2974136.175546053701391124@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 15:18, Kieran Bingham wrote:
> Presently with SoftISP being CPU only - physically contiguous memory is
> not required.

Yes, I've misinterpreted what we discussed, udmabuf should be enough on 
qcom.

> Bryan, will this still be true when you have a GPU based ISP ? Will that
> require physically contiguous memory ? Or will the mapping into the GPU
> handle any required translations?

I believe it should be fine because we do glTexImage2D on the way in ATM 
and have support for eglCreateImageKHR(.., .., .., .., .., 
   EGL_DMA_BUF_PLANE0_FD_EXT, dma_fd); but in either case phys contig 
doesn't matter.

---
bod

