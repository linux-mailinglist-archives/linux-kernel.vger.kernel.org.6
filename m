Return-Path: <linux-kernel+bounces-559238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BFA5F12F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8027AC587
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D96265CCA;
	Thu, 13 Mar 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="W5ZpnldR"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C972641DD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862661; cv=none; b=qNeoUd/LicOldJ2IJclCrRuEyfZrpe4i/DcJ580y8Bnm5VxINKg4gjd5DMU6w+BA53ocbmGlvWB6XpiRIU+lYfS4cZVmNqZsWWX7iaHJJxK4nzD2xWZ5LShXKfiaN93w80ByRbRF0ZX6tb5oAXfn1a9i46X/7FmdI5ihZTsrG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862661; c=relaxed/simple;
	bh=cdJZRMBGrkonFB3hvNUzys+FuUKN9910SmSB9F1d9xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlPeFJKUx8meD+y5ltE93He9kOcPTftAN1Fl+o5jsTfoDgCMi0ReZZYOHFPSH9jhPRXTSCSdcAkakneKo/vkfqkNYUGPKQ4x8Z7CH9GrFX2ogomTCZmriIrH3Kzy1gboeJAmDb1EJbasE9AFkQvS0rSOKVsWiGy+Ort7610VtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=W5ZpnldR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso1430324a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741862659; x=1742467459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek1S1M2Z/3jRrIpDz7olPRb3vs2yw04VJj39Sas7Xhc=;
        b=W5ZpnldRQfxcSJJinZVeOcGGXQfAX49Kypw13lm1k9ifGsLkO2alZ2e/WEcN9RxQA0
         D54te9B60rKU0TItcrivmXHWUgw1+VNTi8TWTL5aKNhu5bG+Kgh+VAFPGdgdWLJmn2Qa
         G/Gbn5Il1b+KVPrdM0fE4ECOns6zvhuEugCN4+FLA+kBK2UIeLIP8ZGTOllycjybHD19
         PsVKL7TGiKDcRtt8dLu8RG4snOzZvJtt0MpH1BIHlDk3GO67DZElgpaNPXtAyKBlG+86
         TXwhrYFzhZNyYQVZjN8e/IyxV/caOpcn8ev4/g2wrzLGAeslKn0TUkfI+lPtF2TIyu+y
         hkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862659; x=1742467459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek1S1M2Z/3jRrIpDz7olPRb3vs2yw04VJj39Sas7Xhc=;
        b=EhchCKNhIcWahm6hPPdn99Qx8VAFUrIYJnNaISlDng4KIayYSJ8UcE1NnOAIjHWW0i
         zdw3JP120OoZXQr4oo/6r8GrCKwrcsu91cdFOj27iV7zh+MWIE5H5GnJwwh7W00hS14f
         BXb+SbqUhbkbcs7ejSZlvA7ImQxXD2Y8jm6TqPoLaBas1tHvEQB6Zu4C4RFR+JG/QThb
         pyvqUwCt5qLbsJRDfn1WllI5ob8q57kStQE4Qdj0fVUebFCFHUzmi/zuZ3CcsBC3uNjF
         Jlz+u3QlWsspSsgOzs2cKbyjMlxIxQTGkBdO5CKhO0JE8H79EIx/0rzhp5/MAARgEU8s
         tAgg==
X-Forwarded-Encrypted: i=1; AJvYcCWv7f5541QG1vQLIrXVKtoixNRS3KoubyZkDJd8jLoQBp3HhQajM3qQWR04UEK2FqBEQgH103Lc1ef/6Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JAC1c/RmFj0VAFFXJMfnkGLE+kCtPdTWKizxwO4Wy5Z1Hqws
	K26g2R7Hz9iGJREn+/gYiQ6X+0vJQtxDt7KXbdsrU74vooO3O6Q3AMXw1ybWM94=
X-Gm-Gg: ASbGnctYQec2OTxdVa6TPjBbkqQxTaTzBqwrnflfiH3MWj0CKLvtmY5tLqX/BgjPR6P
	xoM0SPDlligbhF8lJceZTZVcAOqd4Qs9xF80jqsp13c5O7i4M/RpY/uVIVRTn7MSye9dY0KMqdp
	yiRSmKWGmZDpSL9nwHs2ccXCWh0Cm7Gn6DhTqs6y0M7CMksj0LpqW92j1dHvpwRUETvs3aytprJ
	VE/ED68UKCwuCM215Llv4VTvTrTmD4Xd00n8p8w5mjzZfj/aNnkMQYet5TA5TmjJ/AwxAsZXHcY
	VVFRNldXiZOuUTg4fvyAROyTXxCHTrfHy4IhO09yxTMRwlWL74b3aN5lE54rgzMqTdVnt4VqlZi
	X
X-Google-Smtp-Source: AGHT+IHsVelts5SRr/WJziCKIuWWVYPcap8L5SU4CGAcvx6m6TS5z81715eoW1D7sFPeTWFvFyFeiA==
X-Received: by 2002:a17:90b:17d0:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2ff7ce7abc1mr36460554a91.13.1741862658705;
        Thu, 13 Mar 2025 03:44:18 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011928706bsm3493605a91.46.2025.03.13.03.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:44:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:44:10 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] introduce io_uring_cmd_import_fixed_vec
Message-ID: <Z9K2-mU3lrlRiV6s@sidongui-MacBookPro.local>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
 <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4217ce-1251-452c-8570-fb36e811b234@gmail.com>

On Thu, Mar 13, 2025 at 08:57:45AM +0000, Pavel Begunkov wrote:
> On 3/12/25 14:23, Sidong Yang wrote:
> > This patche series introduce io_uring_cmd_import_vec. With this function,
> > Multiple fixed buffer could be used in uring cmd. It's vectored version
> > for io_uring_cmd_import_fixed(). Also this patch series includes a usage
> > for new api for encoded read in btrfs by using uring cmd.
> 
> Pretty much same thing, we're still left with 2 allocations in the
> hot path. What I think we can do here is to add caching on the
> io_uring side as we do with rw / net, but that would be invisible
> for cmd drivers. And that cache can be reused for normal iovec imports.
> 
> https://github.com/isilence/linux.git regvec-import-cmd
> (link for convenience)
> https://github.com/isilence/linux/tree/regvec-import-cmd
> 
> Not really target tested, no btrfs, not any other user, just an idea.
> There are 4 patches, but the top 3 are of interest.

Thanks, I justed checked the commits now. I think cache is good to resolve
this without allocation if cache hit. Let me reimpl this idea and test it
for btrfs.

> 
> Another way would be to cache in btrfs, but then btrfs would need to
> care about locking for the cache and some other bits, and we wouldn't
> be able to reuse it for other drivers.

Agreed, it could be better to reuse it for other driver.

Thanks,
Sidong
> 
> -- 
> Pavel Begunkov
> 

