Return-Path: <linux-kernel+bounces-576731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3AA713B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6437817125C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A24187872;
	Wed, 26 Mar 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ak7uKRbT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40B78F5F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981483; cv=none; b=B8xnms10G0HXDvbCTMeCpcE3YvX3PK9LKJXkC9mXs5Z6RDOTdFfybMI00kJenr8u64rDLYbXCHVDOxKelzuST6Bhv6b5f5CyV2sBB2M9JKmqMDWcWDaCfPn7vibyP1os/TfGzUOlBj5QXP8W8UagSEB0bTtbxDQgcQvvUaZejSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981483; c=relaxed/simple;
	bh=loPqL4Kzk/Oo6HnpyrF71a3w3MxQR6gpLCL+cbTzRKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5+WQj7pbZG1xJzrkyRWYdIzJ0/FBGAMiNrIX6CmfMF3QnWi5VLR7IIO/i2QmzKjJDlAOd+jlrbjCzOmvSuPcXtGC7Tklgac3V99w+gi0sZngupLEcO4GrfFIzNJYG29sJeIuHMHjkYYBWvGK6bj7E1iTGoOANqApDabuw9mBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ak7uKRbT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c915749so89199075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742981481; x=1743586281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC3l3dK9o93j7uA3wfBStTjnTsQtN1PCfhsmAuTgrmU=;
        b=Ak7uKRbTtTgC7Hq4pm9SAA05RF9vX6Kt5YrjYW6Scfq3pVJdN81X4oIvtEaxglPVV7
         tBEXuZQXwSz4LOHedLBWWALESitu9VKx+vmBEOjMui9xag9JcSfvsHdfFN8SEo1pMGSd
         lbwG6P9sKzskJXTi7XtoGTUNPRMF/JAmq9B3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981481; x=1743586281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC3l3dK9o93j7uA3wfBStTjnTsQtN1PCfhsmAuTgrmU=;
        b=AFH5HL+oPCKa1HNILWgjy4MmyQtPcIWgzKFCe1lUnELEa62N2EaZGmX61YDwkwH1Jl
         Ehfuf65HmRpFIJ6HLbM5NxBM2JAqjzX97HacjScqPvizB1g5J422QEgDRnUD2eliyJlZ
         cHF9JIXJiBx/zoPi5g6uCjZ/RUhVYOlvKkGCZEi5vf0c8ZhKy92GhuBjQ3mAtxSUs5kR
         Ua3qncOM/zdvbk8jC8TfdigEIaC9b+JklpWpN8k9MAlTeDVZaALt8shxPUjw0bBe/Vvf
         F14A8kfkBOk4gnjqR18QTKWpSG7Jq2we0GvTZRM+qXrg6LuQF+wyN1BVzIWO7+WEPxQx
         iFRg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+2PpmM8anf0fWOiz56lqLfHm/DtUXeVsDIqDmzGuyWjyPl3y8AXMKs3Tyy73efAt67CpqOgeypQosKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70MAxd8RY/I/hEQUXNrTW2I1uNVcAu2jZ0S/+/IrHIZu/rJW9
	X0CWQ713cXVrHqAwQdTxFiRmsARn6zu2wll/n25nasltNozqrWrdRL8G9bMc3A==
X-Gm-Gg: ASbGncvJJXDbGOSqxIAUejFxNVHW+XdAVq2XEgsScf3iqqYW5pBny31xqkvi1kWtiGJ
	FeGgSGaCRkEC1H/GpzyEQgEJXNekQMw7Juahtz46syxbGZcsyAxDKNd+HeC6elXaAYpfkUX0yWf
	I1B+eowUNzSxgy5m4k5uTNjlhBmbk9uN/zwqeaUPB7xCFgd5mZ9DWX0P6lwns2nke4MTdbmUs+M
	sGw3CLJuNHErlVo3B9NBQWMehPxsiIzFZdML5Sey5k6boVgKyUDIDxX3FZRGJAZ74BP2YhH32Vr
	rKKuGEwFyixveYfV6vRcQlax8knUhOv+rnD2S/w89Nvrh0+B
X-Google-Smtp-Source: AGHT+IF7i1ahIIFG+ik/yENr8XywdSg6HK7u19YXC7FIIEwyAHubTe0q6NcRcbnoWVAjzdyzxTa+hw==
X-Received: by 2002:a17:902:f609:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22780e121bfmr351614025ad.39.1742981480992;
        Wed, 26 Mar 2025 02:31:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d343:29c5:4565:9d95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da9dbsm105511135ad.179.2025.03.26.02.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:31:20 -0700 (PDT)
Date: Wed, 26 Mar 2025 18:31:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: modernize writeback interface
Message-ID: <oc53hpg3st6v3okm5nbaolx6wpnw5tgsat2g4ycgkzze4yxwdv@7brgfyi7jynh>
References: <20250325034210.3337080-1-senozhatsky@chromium.org>
 <Z-MlsM2Gmxdvl_1D@google.com>
 <CALC_0q8Mv_UWvFjo3HW_gRsG2N8P--R1OqDj7=2x_98XiRXy4w@mail.gmail.com>
 <5l4pjqlgu4afndn3ysa7ynecjmvepkfjlh56ycm5jt5e4mioqm@dujakwaomhlk>
 <CALC_0q9hRAX=46Zd+qh5Pq1myXx+=9gSTT5hu7t1s_Ko4xd_Og@mail.gmail.com>
 <iiav3vvvvu7lzcl3e2rzfh4kyz6kwymqurncjdsv62wvlge63k@ewgbdmzdnb2p>
 <awuyw4jfm2nwxxunchaxazc27m6gqkcyn7zx4gkin7fqg3ogrc@uq55swn7atrx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awuyw4jfm2nwxxunchaxazc27m6gqkcyn7zx4gkin7fqg3ogrc@uq55swn7atrx>

On (25/03/26 17:45), Sergey Senozhatsky wrote:
> On (25/03/26 17:15), Sergey Senozhatsky wrote:
> > On (25/03/26 15:07), Richard Chang wrote:
> > [..]
> > > Another alternative thought, how about page_index supporting both
> > > single instance and ranges?
> > > The key is shorter and the parser is relatively simpler.
> > > Eg: page_index=500 page_index=10000-10001
> > 
> > I probably can look into it.
> 
> Can't say I really like that "index" will mean both index and
> a range of indexes.  But let me think more.

We can permit multiple page_index= as well

	page_index=1000 page_index=2000 page_indexes=5000-6000

because one element range (N-N+1) can easily waste more space
than page_index.  (historically zram permitted only one page_index
per call.)

And plural for index comes at two extra bytes, which seems fine.

I'll wait for more opinions.

---

                if (!strcmp(param, "page_index")) {
                        err = parse_page_index(val, nr_pages, &lo, &hi);
                        if (err) {
                                ret = err;
                                goto release_init_lock;
                        }

                        scan_slots_for_writeback(zram, mode, lo, hi, ctl);
                        continue;
                }

                if (!strcmp(param, "page_indexes")) {
                        err = parse_page_indexes(val, nr_pages, &lo, &hi);
                        if (err) {
                                ret = err;
                                goto release_init_lock;
                        }

                        scan_slots_for_writeback(zram, mode, lo, hi, ctl);
                        continue;
                }

