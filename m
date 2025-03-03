Return-Path: <linux-kernel+bounces-542722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECAAA4CCE2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3406A3A91D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949C2356C7;
	Mon,  3 Mar 2025 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vpn8FO5E"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216371C8FB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034749; cv=none; b=BeRVSShhSuNXvwFX4r6ze+8Ob4LbYLIN9e2kRJj7YpJlzwR6AR6YbkS2kd5vgf3gC3XsoloQG3fNByCpVOhevfzURbTofjmZHdWjRt09pxz7ze5Z0nfWw9sqZS952va/W2H+GOC+96tups9YFogu/VgbGFIJqyAn2UbsxZmBr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034749; c=relaxed/simple;
	bh=KtRtIkf+tI8CYP8SpRXKM3DIxX2i9Sg9C47rtalN4zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK3tuLZibtezDsiSQ2ElJ/gzGaUNGi5gTJeeYRjWyrnFXqzojJ1UHELDTlx86ykV+iHOAvB1nc4S1EOJh1Bi8G883W6qDCKAgLwp2UMlZqi2+oBc3Bfd4hrcYJLxYQqw+C3uR6zUubEBUKWFGEMe3qL8QvaM6fnSusk8khq0NuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vpn8FO5E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2234e4b079cso89178945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741034747; x=1741639547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XGk7Og2gqDlm9MRY3vaFJ22GyXfdVp9nEi+0rQBKok=;
        b=vpn8FO5EoejUR6TRVk0cgM4FEi1K4yRllPB8zzvpzsXEktNslkdGlTxVcxZpZDKLmR
         5vJw4EQPyw6ZxfBOV/na8IZRiuvJltS5KmYjrF26d6Q+cQim0BFCJhryhbl/8+zOJZ42
         B2iDsZ+SdsxwC8z44HHUQE/fc3GTOhF9+vEj2IBA2R8lCPNt28HrTfcuqkEfYjgSaaVp
         HV3PRMb6dqhRv2upDYZFA5NHlEfxd0zvBDxW0bwcp1aV7d8bTtgjMuZsF06uN1Wm7TCZ
         2J9B8kQiHxP6OIm62fBkji7FjN0ioPFtt33Pf7iZaP7/jcsx15jFcWn37Lao05DufcPV
         Xsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034747; x=1741639547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XGk7Og2gqDlm9MRY3vaFJ22GyXfdVp9nEi+0rQBKok=;
        b=mGOZcLmIgzqEyWyzfh37QU5G84mcVqpVtVhBPtc35ZyHV1yKZDzafRRZiwMzLPr6X1
         jW2NeC3PEZNcaCow2FL02m+ZpAWmZllQ9FeRukpbjUNHD29OluFuZilz1zZO5ULUDOVC
         AoDoZ6xC+OXTgrYht3dQb0iJcSuMRvlfPNl5FUqh030WIThCbd/jLldRvc6MS5rPUZs5
         t2rfJ5DnoUkHm8rUCLMRLkhH7JjdM5wh5/o78QbDMuNuv2EJ+P7eqfFa2qSB8zMkV055
         Y7eMCO+KglNNUEdOfnNftOjdV6s18ErNBhVNgXIdNj2jOE5Wp8C/0WZBz9fGcZMx9lTT
         FXVw==
X-Forwarded-Encrypted: i=1; AJvYcCW8IYE+bNsjozvWrLgjx/7T+k8h8z4fpw2hLefqWvGw54W+SSrPwGfJvDfjA8Z0BwA9KR8w3hhMTiWyFj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZc4nYYrkX5Shd0XkuqCvhmuJ7vtwrDQFt5WSUfeadqiDG4Z/R
	DCqFlManvdoB0VLF+AbyYKv99EdpzMB+pQpY2jNDX2clYvxjvf/yqWQi5s6dcEE=
X-Gm-Gg: ASbGncvQpJ7E5k+hAw6ISP750h0zl0l7X1u1DYAk7O/Lx4c6tCcHLjwnYBPj2bYmK/g
	fuK0xFkd8JrSF6rtSEzPTZCrN8trF2+uhRk2ywdzGsdrijiVuwCMmb9zmvHp/rDEREvCSu9A6sE
	jB8xJpGXPAjlpyJRDnNNAZRwhmZS9s/0CGUPNs08SvtdNBfjZXUnQGRc8RTXPrLS1ASNMJ55mrd
	NUFzsGdDIrv9XBgTSzu26cSa10NxAS3MpjM+2XhvV7luGLF4bjxR3OxkRQdepADg+LuaRSlRVnk
	qa40+Qodh36y0guzzR8dhoREmR9wJo5seK5Li0swGBFhsqcuA9MiS5OtaYg84FTevV3xBAMsp7a
	bygBNchOssVd8eSHjQffM
X-Google-Smtp-Source: AGHT+IH/B18pydy8Pnt7mD3QKhmW6vpxyYQaJWgWpx4izblpWCTAeLTww3Zr6v1OCs7KiIQFew0hqg==
X-Received: by 2002:a17:903:18a:b0:216:5448:22a4 with SMTP id d9443c01a7336-22368f6dc74mr259198795ad.10.1741034747418;
        Mon, 03 Mar 2025 12:45:47 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223d4b94c25sm5167435ad.49.2025.03.03.12.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:45:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpCfY-00000008Spz-0vWy;
	Tue, 04 Mar 2025 07:45:44 +1100
Date: Tue, 4 Mar 2025 07:45:44 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: cem@kernel.org, djwong@kernel.org, dchinner@redhat.com,
	alexjlzheng@tencent.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: don't allow log recover IO to be throttled
Message-ID: <Z8YU-BYfB2SCwtW6@dread.disaster.area>
References: <20250303112301.766938-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303112301.766938-1-alexjlzheng@tencent.com>

On Mon, Mar 03, 2025 at 07:23:01PM +0800, Jinliang Zheng wrote:
> When recovering a large filesystem, avoid log recover IO being
> throttled by rq_qos_throttle().

Why?

The only writes to the journal during recovery are to clear stale
blocks - it's only a very small part of the IO that journal recovery
typically does. What problem happens when these writes are
throttled?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

