Return-Path: <linux-kernel+bounces-576681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A13A71300
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E0E170E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C596417CA1B;
	Wed, 26 Mar 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ess85WSl"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7B1DFDE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978766; cv=none; b=As9d+Qzp86nPinY8mkqgd873T4jWQuYyc+hKov4GpokMqarBmIK9a80wxjZIo3ufWKReVDUDi+tectbpojiwERBtacA5nGCjZlLxr5Eg3mr8/x+SPyDbI/JqRNrafqeRNlcp4VU+MT4c9BFAnkXK12NPj3ulT9/McfW+K8WmlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978766; c=relaxed/simple;
	bh=D9Q6Bq7rIfP8pL1DuBYQK0tNWYv+vU65XyhnzF+UYlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tto5h3fxxYv0eoISPgwKWSL8JPUHmdZB0ulyu1lS2g25+BiJr7e9/4WfKHW8RG6vceTz2tbc5Fha/pRMKNFJj/si21Aff8v7IXDxlW5cTcHMMC6iVsXhIv7IWdEnq+cke3VsDB6FgN/f7s65u7o3VWOWbxQtxgA0IvUeXCWY8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ess85WSl; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3015001f862so8178363a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742978762; x=1743583562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTKaj6KL96qFCBnkU6QrFMZuOf/XUp8SJyy8b7qf9F8=;
        b=Ess85WSlnZVBdTgu/A0jRK/1NY11CAbwbVSOjI/O/98jt6k9jQYkjywsXCUgv1pNuq
         tRmBbUtqfWVF4rXhdXto5INHbw5e2AgMSfVzZIts3audVsqZBeXZmGWo7ueDv4hEJOXR
         nCdxb3GFQ694gG6PBVLEfaz9mwAuKwYbz74oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742978762; x=1743583562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTKaj6KL96qFCBnkU6QrFMZuOf/XUp8SJyy8b7qf9F8=;
        b=XoJDszGTBNsU0xRBgzEYdg6KciS8TUH7CbR0BQ5JAZFW9YH2UKQDEpk5VBwtwupPcX
         jePZxlLyT8S9wpHVzrYku9ficQ4a/JCXUj5i2tsR9omFc4bYn03rqR/W/CbkAzam/cVq
         5S6Nz/0VgK5hm9CFBp+W4mJXXFBOcoJI3itqUe6jaILmapssVRL8Vg1NrHF6rebBmpvy
         eutfP4osgLNfj70996IVyLGAAH4tdrthgBpcacKSLO2M0+rE8YLyHRK2VheulwEgramH
         7tpfrdnwyTsU+2kwxs+01U8m6rd+Vvxm+NlR7c7niEDA3Ol66kKW3FtmOuQqCjxhiGuE
         16Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXVoyRZYQpHlp4h3q7AlhtHQg1zxHELCz/UTR/onVF0dDc2fsf9m+aoHEyoXvoJgktV2lklBoHLpG9kftg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnnUkQt4Todvh2VQNaZXgS3YHZ3fZj4QPiULeW8DXszoJp63w
	7UAUlzZi5AIY3ZCl+qQDSrPPegTSNRcqG01H/4pOpReUhVAc/t4Y7JcfWT5WaA==
X-Gm-Gg: ASbGncuCKd9a71WsyBDBT74trJEy2b1QADk5TsH0+VzEO/HLJlMavH1NGxak95HcDA5
	iI4/uE2dYTX30YMQht5X71vJ3cXx9BvMWSd1MZfBDA1PjJRcUUuKeHKR70OnjdvBm6EDWVhuVwB
	Iu0gycMUtM+gFp39ryNdzvhZ/tGcZK3Gf7y6LNJigLNpDuWC+YhfR9eYGc2Hm84zhUScBrczkgR
	M+zVzgD3Y1HlrO6XSYOclJCgp01psA9Edwx7g/LukzuronJPiu6MGDkQm5VRpDAWNJxG90Ako93
	T48aB/hUoERGkah+y9flITsnEIxGr9WMXOll+BZdglJ/YxCP
X-Google-Smtp-Source: AGHT+IGisvnfs4SlEXOwlnXep8AOnrWVjOmA+e82dVgBI4R5OxY1nQbWHtCBn1UGC10gQ6jKlVnTrA==
X-Received: by 2002:a17:90b:134c:b0:2ff:53ad:a0f4 with SMTP id 98e67ed59e1d1-3030fe93f0dmr39067080a91.12.1742978761631;
        Wed, 26 Mar 2025 01:46:01 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d343:29c5:4565:9d95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3037c8ecaf8sm843442a91.0.2025.03.26.01.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:46:01 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:45:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: modernize writeback interface
Message-ID: <awuyw4jfm2nwxxunchaxazc27m6gqkcyn7zx4gkin7fqg3ogrc@uq55swn7atrx>
References: <20250325034210.3337080-1-senozhatsky@chromium.org>
 <Z-MlsM2Gmxdvl_1D@google.com>
 <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>
 <5l4pjqlgu4afndn3ysa7ynecjmvepkfjlh56ycm5jt5e4mioqm@dujakwaomhlk>
 <CALC_0q9hRAX=46Zd+qh5Pq1myXx+=9gSTT5hu7t1s_Ko4xd_Og@mail.gmail.com>
 <iiav3vvvvu7lzcl3e2rzfh4kyz6kwymqurncjdsv62wvlge63k@ewgbdmzdnb2p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iiav3vvvvu7lzcl3e2rzfh4kyz6kwymqurncjdsv62wvlge63k@ewgbdmzdnb2p>

On (25/03/26 17:15), Sergey Senozhatsky wrote:
> On (25/03/26 15:07), Richard Chang wrote:
> [..]
> > Another alternative thought, how about page_index supporting both
> > single instance and ranges?
> > The key is shorter and the parser is relatively simpler.
> > Eg: page_index=500 page_index=10000-10001
> 
> I probably can look into it.

Can't say I really like that "index" will mean both index and
a range of indexes.  But let me think more.

