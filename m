Return-Path: <linux-kernel+bounces-512118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6EA33449
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AFB1886A13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F278C9C;
	Thu, 13 Feb 2025 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="by6pz6No"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205869D2B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408039; cv=none; b=mMsaYjTAKiFNMdGr/ZsvthHiXHVhbjVU3+LjuNI70Fj2kLMGUIPI/9aBixnMYkqZOnyw7CLD1ek5VlkJ27mkpWsgG/ix2Dkm8A2DVCzUrLLOMgrl1iQBnFjStkyx0cdwt+4ViZorWv9x9VMUJXEL9h6FQLNmQP1+whSYNu80F2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408039; c=relaxed/simple;
	bh=umI5wmS0c0hTUICOiyc8v97ZzYfRJ2GaqqMRM486M30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7tIiuYuft+gKQhJDtVfD3RMQG3nmj3bTXyt7gePrnOAQFNKb3Gyz8wWHlPo48m1cFx4sIkGM/VIBnBIZNUqiCcbwcewKTMQkzIOSb08ydcxKy2Nn+DiORZI/yYsL2oEQw1mclGNzqXiowpts/zA2AeFh+0P9GJ+ojstkmKoZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=by6pz6No; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa44590eebso761897a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739408037; x=1740012837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01DdFj3ajbyqhSMiK0bro5CxbBH+WJZd0MulCBK6saU=;
        b=by6pz6NowUP2TOCethXmraDIT/cxrCv7qc9ONSfOmi+EzCJMMviFy38j0CTPIvCpmi
         564pOeZDZRQp9YD2+avCKmHDcnFGsgDraKcy50XlgUiisaxb+B1I1UfSFFdvkca3gY0X
         xwGPS8Pl4NYmeHWE0iwhamY+dOBIH5w+LAbj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739408037; x=1740012837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01DdFj3ajbyqhSMiK0bro5CxbBH+WJZd0MulCBK6saU=;
        b=T7C+B2fIAfwkXxhT42cCURhkYHmzIrBdkHOSBDEmXEU/GQyvGb1NoguBfpDBr9lsVt
         BY6APA/eBHWs2/E/7sepZe6wJnRuPZKFtfI4Gd0U1F3GZIJZjIEVNIKgD+r75v9EKU8d
         zB1oc/WNFppFomn9OD4bAPv3O4msMv0Fgh+vUFBKiD5MJvsPfuynIK2n2WvppnJ6yt91
         VBMKJKrm3S2b4OpkbedDbHJDVA8b5ePKUp1zHwm27f0iR9VyMm7nhyiuzBdWOToiYWi3
         ll0QcMudvJplqQmLK0Qoi5yKpCzJhjnoYZYDDA4omSDk8XwRGMF2bXPYFAXxOQpjMLU+
         97pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcpxKaMu/k2PHCTU0badRXQNePcsaEvwrT1gNM9/3KByMGNFXhVRkGdHk0nWUmR1actQhgq/O1DR4EqyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEmSUtCscECRaCd74CpMNA1W/geOedPgziC79ESiiw8qUcJ6y
	CaiJWZc1WvuicpC1XMxrG7I7KgKSVPKY5jhK68/y+tvbFY541OsgIMj4bK4bew==
X-Gm-Gg: ASbGncs1mXZ1O5u6WX5sZhOLqjBiakvmP9YlMDy4ENEI51Y4R728/HVjF41hZWW/1OI
	ibRWKoHwxB1gQE+Y+QMhR46lVrg614BBVyBFMAxHOYloWHORDBXbbMYsJB+U8do6i3YUCH9IuNe
	yyMDBED9LB5o2cUR1NwMLDwGjDUD8nKOaHcdf2X325WfIyccy4DCll3hjsSr1W9Ech5EViIfLaT
	W3Ub/nRVr0NOVtslo7ha761hipiNbjMZmZ+bXZMPAz2EUnWnZuTE9PJ04j0UnH98swYoPbhEFv1
	tODWUi35Gjwht+CbUfg=
X-Google-Smtp-Source: AGHT+IF0S8E/EiKrT0otapMw8+e9E8XG5Pnyd5x2RjF4xipOwBd6PYuj3SBKfJijHDQgtR1d+cdjtg==
X-Received: by 2002:a17:90b:50d0:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2fc0e2c0cc5mr2214021a91.12.1739408036849;
        Wed, 12 Feb 2025 16:53:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5367412sm1530825ad.99.2025.02.12.16.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:53:56 -0800 (PST)
Date: Thu, 13 Feb 2025 09:53:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/18] zram: remove crypto include
Message-ID: <pgwg347rue5gpa2yanva2rrzvpjxuh6imo4dvs2eb3alnoolmd@fhx5ydowgcce>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-4-senozhatsky@chromium.org>
 <Z6zIuC0Dv2pcwSDy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zIuC0Dv2pcwSDy@google.com>

On (25/02/12 16:13), Yosry Ahmed wrote:
> On Wed, Feb 12, 2025 at 03:27:01PM +0900, Sergey Senozhatsky wrote:
> > Remove a leftover crypto header include.
> 
> The subject and log is not very descriptive imo. We stop using
> CRYPTO_MAX_ALG_NAME and define our own limit in zram, and removing the
> include is just an artifact of that.

Ack.

