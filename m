Return-Path: <linux-kernel+bounces-235335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4529191D413
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F1A1F20F22
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99573487BF;
	Sun, 30 Jun 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eETzfaWi"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312213BBED
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781211; cv=none; b=NrMS+uYBFmKoCEP/uoSfZnkQM3gEaIOQrdlyWK1rMOYbeqv1J/IN+HrsAmV30k9yqcwem+IRupuZCG+3Fnsz1/EwfwtU9hP5jKPsU5/P5EyFeuhPoB61bPpHva7HCUZm/CPpdoayfADJ5NA7/EVwgxfTdX1UxoUvPJeaOGJE/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781211; c=relaxed/simple;
	bh=i3wBYlqAIyF7MLWogFpV04w0P2hN8DXWsFDnDcqG+Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/d93NqHGX1MNidZ8HL+/a4kbWr3A1WDH5IYiftruDVzQsaCgbzQIGT+Wr9jSGwT90Cp3u2TAeTTwzCMEitrmT/W+gcIviHz2j4eJg1/Rrl7aBjfSQLuX2/7nBTBrGVV26NAOO5SL1/7dssMXvkWnhupI9dWpMrh8AtcG86begU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eETzfaWi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42565670e20so19727585e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719781207; x=1720386007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlwJlLcNa+mcZF0VRgSNE2c+ZwSPVwbYvfTh5wNjyKc=;
        b=eETzfaWiZLVBV5dBk6RF9O+4srco9AUoS5vASc+8FAb1MMvupRywYlFbvju8YgQhS5
         kvcTdKTq2pCZImQBhZl1wZzk0mvl9w8vTxKo7e00YqhRaMaKe8khHF50QkwjGGRARTDa
         VzuH4JFFl4wxW4bC6S9CJoMdwFp+cK6iQNsjPhMfJtly2y1fZ7mGjBcoiPSOwW8V2UpP
         BQ3BbWKyTJKDbreVshHIUdHT9sn6S8qqyOVvZ3zavIPTv6QQv61NrNsgdKTz6ZSB/wk2
         Uhwej02ev8EiqrgdV3kSZtmer4FVGcuvq1jxhXTkLHf9tiVGzSxs7awR/81FxBu4cJFm
         c5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719781207; x=1720386007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlwJlLcNa+mcZF0VRgSNE2c+ZwSPVwbYvfTh5wNjyKc=;
        b=WLPL+fbxQJpiTJ5xN+8CUSn0LluskZy/8aLR05kNmP0+pJt5avlzjUoaE1FGf+08CT
         +OBwcT9JyBnBhRx+KAgepKBzc9Wa+ijc6sQdhE6knz2IrCCM69uNLlw2+JbWJvvwnchS
         xlZ+vguOYPxXbcV/5P1013dhNvN2BGSBoK1iqSPAMGRSNnnTQjas0U45ReVuLcgkpw6c
         EPBTtRK0oVyr17F7LdA+FMUuKseFFZ8zf/v2UY/CPTCjm/coKSVbA72CDs7uJYt2UD9l
         NxB4VLZyx61nmUEKLJ3pZ0UHMnLPeNtBDbPl5d+ZFYdDB0uzWVbijA6mDxg/BznzLs5g
         q0SA==
X-Forwarded-Encrypted: i=1; AJvYcCUfKWwWp0xTlxQIqhPI0ckuJ5+niimJQH4LRmv3HUtwXz9fmJTfvQZcai/C9V8BW9fhAudHhhvs7aO9Poil70XlgqLMHS0TyzVEiA5R
X-Gm-Message-State: AOJu0YzsVnE5Hou6cIn2PsKgfDYzHaVsjBG5NiArpQItieC39pAmrDwv
	4XLG9cR1FnDPyArD0fNP++AblpdJwos0fzV5cXjkDBfJJ5fhlhxq
X-Google-Smtp-Source: AGHT+IGoSqyJ4wAZ7CrPtTe3kqYuw7KYOiZIH4YMy1MgPp1kZydZTr7Pxi2pQ0owP7SDvzSVDpMuaw==
X-Received: by 2002:a05:600c:5113:b0:424:8836:310c with SMTP id 5b1f17b1804b1-4256d4d3063mr62911005e9.5.1719781207309;
        Sun, 30 Jun 2024 14:00:07 -0700 (PDT)
Received: from debian ([67.208.53.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c1018sm122954805e9.40.2024.06.30.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 14:00:06 -0700 (PDT)
Date: Sun, 30 Jun 2024 22:00:05 +0100
From: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To: linux@treblig.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org, linux@treblig.org
Subject: Re: [PATCH 1/3] parport: Remove 'drivers' list
Message-ID: <ZoHHVcYSOho2Yfro@debian>
References: <20240502154823.67235-1-linux@treblig.org>
 <20240502154823.67235-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502154823.67235-2-linux@treblig.org>

On Thu, May 02, 2024 at 04:48:21PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The list has been empty since:
>  'commit 3275158fa52a ("parport: remove use of devmodel")'
> 
> This also means we can remove the 'list_head' from
> struct parport_driver.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, can you please take the series.

-- 
Regards
Sudip

