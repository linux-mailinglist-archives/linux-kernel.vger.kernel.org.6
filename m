Return-Path: <linux-kernel+bounces-565627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F012A66C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1563B42145E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611701EF379;
	Tue, 18 Mar 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="QlaZblXu"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9EC1E5B8C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283686; cv=none; b=iqjo/FMyiYdfGkaD5qBKJY7d2mnpjn2oJRlQ+JYN+sgxX8eCSDmZ7f7Lnp+YC2Nzd9Uqoh9Ri1gWqqoG51FpObPYG44TSPFb2MSlQjixX3T2nwRAFIxviqmty+laHyWASV//cbUORzHYBygtxM2wWK7N8BgQJ006lGuWnDgtGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283686; c=relaxed/simple;
	bh=JcP81Ufkh8a4+FR/B0XKynUv7tTtPwZ8DFCJsDVbLC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnnnCM2J0YtpPnkckcD3Ugur7QxVknHMZQWUzpjb+mj92yUTtDLj0OLn+y8Q+D6+yxkJRkqOpnFPSUue9t9Rhw+dpCwNkXE1j/OSQWTzVZNySE6Zrxk1qojEvpGHdTm7ak+/BCsEeFwVHSpMWyJogy86emwju2YHzzwvhyX+6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=QlaZblXu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22403cbb47fso96316655ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742283684; x=1742888484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNvQ6tpEHu4cEr7G/ExgaM8GHz4Ko2OdeuJkFdAQxmM=;
        b=QlaZblXuC9z4dA5S96JSxgC/+QK0lPIgRcjv9ySBw22T6NuTCwkCNFHjvATacT0aMS
         wwmeefYmgxV9M6gDPrNob7gJ1fPIXq/6tmdX3e2iY1CGMtT3HOWjfSy8uph0hN+Eq1f2
         YD1+9XFy0UTLYs3gL+kIb/cuMtrhPKnO5o9O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283684; x=1742888484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNvQ6tpEHu4cEr7G/ExgaM8GHz4Ko2OdeuJkFdAQxmM=;
        b=od647mW9vZ1q4t8LQh8w+KKTnnSTeIM/UPCzdPUnNXh34zep8/ZomGZXttxwe/PedR
         EoOfSgKtxPeW3sT/obEOiMw1Pw353IrP+3CwKPdJ17F8Fgbdf9pANlfW1oTF6VH4cNCW
         eAvw/rV+/TqNT6iN06VEmhHTuBqlfkatiZcfuKIfhOGjkirGS45i6uzWE5hkW6RceqaO
         idgDHDkkc+WBoGkCDUYccYb44Y4psx3dlHxrG+VknllYCJ2jkma64RAZ3larQHPr94rB
         3262OpacMr2apzkm1kPuIPIHUizct8qfIPI+YRE9gcAJLOuUSJatPkwrUXRlaeh7g/gp
         x3/g==
X-Forwarded-Encrypted: i=1; AJvYcCXJMzV/ZN8DPLOC8iRuVWDAbibnYdhp+dQfTieSLl/WVcp70QN5QAThiFqTkmQAPdY412uJ7HzTADJ0Z8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy81fZnahbjOwcO0n8qk9lQwU3i3noaFuI9UAP6ZvWDtEmyH8X8
	BqOw1DfovYsOXNj2wwQpcQaPu3mqZoYUVBo2EFvAdMSmFP5zT2TmT9QVo8BAupU=
X-Gm-Gg: ASbGncs5kjKoYMYTqPlhJ8ZJcWdYlFs24EZySsKYq+7WcPeFFlOVCxrQnjL79ulOcEu
	RUxUgQ+dYuuoBq+cfmRR7beCMZ3FBYQBlws1mhDSYwUGYWPuSgnLwvFoIkapA17WHJ6F4t6ZSp6
	0tl3zoM0K3jS7WUQdJO94WXCqlr1JKQJAgsH9xUHR0XAsXjEMGmznViYzNXfAqDHPqEa8+LN/bl
	3++LQMU8RzjvIfLMK5+y7s9U2hPw4XictrkpRhFgSyL+mKriPsPi6Cnj4YuieLcPAMRWeU8z9iL
	101Tp1npVJqb4vBrA01RmFkOFOhC2vM5ZPlEfl8EpsSiTryAZAQOJ37nfa8nwVz9BtHd7kRgq3i
	gYb0vleyfpmE=
X-Google-Smtp-Source: AGHT+IGhFAnuORPDCa7985AEuLYw1DqSB5HkYgp1IM9MykQ1Es3utP38TfZs+Lp4ptOx3gOLYo1VNQ==
X-Received: by 2002:a17:903:2ec3:b0:218:a43c:571e with SMTP id d9443c01a7336-225e0a9c832mr206732775ad.28.1742283684564;
        Tue, 18 Mar 2025 00:41:24 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688da81sm87854535ad.43.2025.03.18.00.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:41:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:41:20 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/5] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9kjoFcHrdE0FSEb@sidongui-MacBookPro.local>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <fe4fd993-8c9d-4e1d-8b75-1035bdb4dcfa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4fd993-8c9d-4e1d-8b75-1035bdb4dcfa@gmail.com>

On Tue, Mar 18, 2025 at 07:30:51AM +0000, Pavel Begunkov wrote:
> On 3/17/25 13:57, Sidong Yang wrote:
> > This patche series introduce io_uring_cmd_import_vec. With this function,
> > Multiple fixed buffer could be used in uring cmd. It's vectored version
> > for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> > for new api for encoded read/write in btrfs by using uring cmd.
> 
> You're vigorously ignoring the previous comment, you can't stick
> your name to my patches and send them as your own, that's not
> going to work. git format-patch and other tools allow to send
> other's patches in the same patch set without mutilating them.

I'm just not familiar with this. That wasn't my intention. Sorry, Your
patches will be included without modification.

Thanks,
Sidong
> 
> -- 
> Pavel Begunkov
> 

