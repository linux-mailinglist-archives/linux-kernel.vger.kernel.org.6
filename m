Return-Path: <linux-kernel+bounces-179179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE798C5CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84938282A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13D181BA6;
	Tue, 14 May 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dVJGaV6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D01E491
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721664; cv=none; b=unEIo7Yt3daeFMNwDscB7owNtiC3EslB9J0OPry8N+4EMfdlheSHYFuu1sZlIb7UH3pyxUZxq8aEzuuWTKYhkyLPhZEx+qKvPUav5MiYMYJhEYAJim6hmR6644V6J9cLEvnHH35P/xMjPFFn620drF96V0D542UuVnmhEUwYb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721664; c=relaxed/simple;
	bh=CwPBPu20Q373SE94/2W5Gs5lJ3zjrSanPFx9uYehg0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgqiPS+CfVU1pc37Y0xiHwtcsHVEl6dSz8pmfxR1PE+Kmck5CKuQCOp8Ws2kBlLCvKORpuJKqHfJGTLr2h+RAWwlpMq2jiRpz3Zlt7bmcRSK7ylBmz0mNK2wmsO2oOEdD3muYV2n5Bu6QeCMlB+6qVKwjw7P516/V8usFtex6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dVJGaV6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42012c85e61so211565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715721661; x=1716326461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwPBPu20Q373SE94/2W5Gs5lJ3zjrSanPFx9uYehg0M=;
        b=4dVJGaV6gbT/74k+v2vX01UiSQm5+J3cdbUp13Ajx0HY0QhCG10FRaeB59efSxCcJ1
         ChieX2dM1//AptnKX2SoKrrwFi3SEGKNX9MSsqenII5v0oOa620JgsQUXoDmcuiyQnXy
         hr1Rl2+sLGwGG2wEQR6DO08/KWVlowi/1Zbp0Qg8hzBGNfc4sTGGeFfJfdvW3L2XxRoR
         j14DfxP24Ef7V5us8d76+nvzFUQdfN6ujqkeACuyTMgmKh7EelBZhgdCw8Co+2YkN9Wu
         V7PpdbLVNRxjKXFyT/Xl5vcgOzDTYO8adtyi/p2vG1KEYOQiJWV/Mq5VemKkz4XRi9YH
         /cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721661; x=1716326461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwPBPu20Q373SE94/2W5Gs5lJ3zjrSanPFx9uYehg0M=;
        b=D9zVSSBvFQlxsroaLdRI1ASCE1tKIZjnec+I4xJMsLrxr94roeHY1Tg+brr8kjAuBa
         Nw3sklumTO/CWBS+t7n0qV/iRyFr1kSrOR0brOP+7NPl/Z9YTdKbyabCg3jsDW2li88b
         nEFJp5MhDKXYnNKf24kFt2VTsUTIkBVTS1I9tMw6Df+c+uF5UkFr2arHoL/6ZanuXYYB
         U4PZElrlVdYqVr7m/OqOc9RUeJ99Z+pItHy6SCmZbUQVNg/DJ4VLOpSfTvgmMtgxrWrN
         uVLREuwoRRv0Z48VJTO9rli0p8e4j2wRihT+xKykf35GHrwWfAuTBtdg7AhWPGxJVixc
         cqbg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrkOZKcfumEdYm0NJvW2QySSrLSbnZvT6MHElwSKe/kcNKoWgtmxwMMFYXiPqHSmrm5wbvx+jlB8QWjXmroBPFcvNuAEaEOpo2MDf
X-Gm-Message-State: AOJu0Yy8kOcisbTpfuAJOfzDpqYV5YBgh5PgwCB4t3p/8JuP7v5ia+VR
	uRT9rJUvsYr0zu7s9YzilNOZdZ790WNcP89uG0vfYwGl8cGXbP8ztzwtWX2OHQ==
X-Google-Smtp-Source: AGHT+IFK25M0wgeXLfHIqwddgM4kRtbQlKmkMGa4V1C30HfAGSGO4wDqOPGaTUCXpXxxKks9YftHWQ==
X-Received: by 2002:a05:600c:1e12:b0:419:b16:9c14 with SMTP id 5b1f17b1804b1-4200f8697eemr7227225e9.1.1715721660799;
        Tue, 14 May 2024 14:21:00 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd491c712sm117556485e9.0.2024.05.14.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:21:00 -0700 (PDT)
Date: Tue, 14 May 2024 21:20:55 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Daniel Latypov <dlatypov@google.com>, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com,
	rmoar@google.com, corbet@lwn.net
Subject: Re: [PATCH v2] Documentation: kunit: Clarify test filter format
Message-ID: <ZkPVt9wyu7f-fC3c@google.com>
References: <20240402125109.1251232-1-jackmanb@google.com>
 <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>

On Wed, Apr 03, 2024 at 02:59:43PM -0700, Daniel Latypov wrote:
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Hi Jonathan, I think this is ready to be applied?

Thanks,
Brendan

