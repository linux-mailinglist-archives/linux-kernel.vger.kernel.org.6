Return-Path: <linux-kernel+bounces-201111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A648FB9B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779941C21359
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588A1494DA;
	Tue,  4 Jun 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L51wCm3/"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2172AF16;
	Tue,  4 Jun 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520301; cv=none; b=TJjiElbozJZ0NQDOM3Mas48x8EAI+3Hu/J57McK2i01vbiE+D/nowDkI3VGWxS1StH+tmuXUlhH6GEOFFGPBcuNxcb/PRgzbrowvUpIHowiUZq+xuiNtarqKeZ+w68FoWX2v4ROyXlgWfWiS3Oh0J2mtusokYDVkvp7LV3vF6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520301; c=relaxed/simple;
	bh=1DyR+KMxq8QLa249kWyuPsFZ6goVO/jlv/qaOX5W1wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka8S3lNPwYi4LnNMVWtBXWr2qPXO2vZam0n6u53Dmgny7cFCM2GMQtzO6vuPDqZhdqOgN31lvqIjkZvYQEp8N42xYz66ySqaDZ5dATESRNw4bWpudPM/BCHydRAiHxSDCIKMm32lXk7dHLox6Yzqe6Cn4i/uYsHm8+EHPU2ufps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L51wCm3/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso4039199b3a.2;
        Tue, 04 Jun 2024 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717520299; x=1718125099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liqanKwgSqpdVt/zzwunTLjcxyz9wXPZJfeDuELZgNU=;
        b=L51wCm3/yOU8x9vUTrteaAnf477gzml+Oztj4GcrtJi5VmSw3R1l7L/P2BXb1jhhlE
         LKfNtKQdjsNPT+82Jchi/x9dkNxthSdDFXgBidLAKr9d0NZFDZW9/6JnPHHFLmuGPB2j
         yzIlGdEa66DFkzVnA0IrHrzZ0FYiKIhelTX4ZsJtoE1rbz310aQvZnIeyw0Y3Z9sweAL
         MVTWn4QXnL6exAZjXT2tCce5MORlADUlsmD+WDPGAwgnBn/0PtPVJF/miGYxFCbaY9qD
         EKfYLRvrsCzongRvn31rzhyKinNvdxBauFBcH92nTFQy3SfTaKh8A7nOjWS1aydTmkaS
         D1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520299; x=1718125099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liqanKwgSqpdVt/zzwunTLjcxyz9wXPZJfeDuELZgNU=;
        b=PwI4f4RdKSoJQMLoqBdkvXCjXNF4F6qa12xecHuRi4nKEP1oMdfVSffYn5Zs2xbefD
         zGzJuMTXkxv49P3UkdPEhMCWwEe6hl55cxlbz6RG3ZEgEvH623Nz168cVd276beb+Cwm
         oPfFOK/A2m6e4SEeT6/9pWLqstXVqDnySYsVFY0MfKqfz/8+QKXJeZUOjcUIvEFVnGw8
         l5ot2NsOYJRvJ3i5eGV9ia4sQZAJVByvge0QAOlBfcVTnrUuTpo5ZzKoZENNcpK3GCuZ
         Tu1wE5Mg35CR3yrh932CGz6XLfS8Lw4zt8TEPx38bRZKe9N2PJ32pzp896lkzoXarcJ6
         lpcg==
X-Forwarded-Encrypted: i=1; AJvYcCUsV7drCMT8T/FKblxtGLsqy+L/LoKME1YKj6cLJO+cm6cAhCOBIopg2/Fb6A3Uez/NOlG8fjX77oIpY3oGEATPqXI81BLScL7rh9hsws8qqRL5v4LCzeSUqfiUe7SQSNhwuPvzknAONquoFsP/Mb1LQbly6CAX94yqv17mosNDLKkl0H3R
X-Gm-Message-State: AOJu0YxQjWCaQVk86RNRvkln5n1Xzs45E/E9Q51L9R/AwdzkhyO1nnwa
	Y6e5NZmz6RZq/FN5nEVtmf8m5uNH3fz2Wr5sf6Hg5IQW4R5GkHsw
X-Google-Smtp-Source: AGHT+IH8ywKVlBvDJdTBKuOHbudOmAAo2HK0Bqbj2hA1VKQcKk1uFzt3Lc1xCAqQ6DjypaIBneWPVg==
X-Received: by 2002:a05:6a20:7f8c:b0:1b2:55e6:836e with SMTP id adf61e73a8af0-1b2b6f4f14emr216669637.24.1717520299484;
        Tue, 04 Jun 2024 09:58:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e44d9sm8392645a91.29.2024.06.04.09.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:58:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 4 Jun 2024 09:58:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: hwmon: g76x: Add support for g761
Message-ID: <48a05fd5-50da-4790-ac7f-2b2a1c40e07e@roeck-us.net>
References: <20240604164348.542-1-ansuelsmth@gmail.com>
 <20240604164348.542-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604164348.542-2-ansuelsmth@gmail.com>

On Tue, Jun 04, 2024 at 06:43:42PM +0200, Christian Marangi wrote:
> Add support for g761 PWM Fan controller. This is an exact copy of g763
> with the difference that it does also support an internal clock
> oscillator.
> 
> With clocks property not defined, the internal clock oscillator is used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

