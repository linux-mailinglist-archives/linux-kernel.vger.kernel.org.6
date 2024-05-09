Return-Path: <linux-kernel+bounces-174415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A88C0E69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6EB23837
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16012F38B;
	Thu,  9 May 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vq3Jmpyh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AB322E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251664; cv=none; b=bBP88UxRj5tDz9zNM48f7C2ckIUgUFBQ9FHWCGFPcxrDKEUH84ZLzlaFViPns0n/anagTYMQH7iH2VOHDabUadQqnXIp0ROfi+/lwH6mFJnJINbsL8EBab27fATL09PzFMLsdWR++DC9bvY8X+VVyzT/QvMHspa01P7rk/jnCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251664; c=relaxed/simple;
	bh=rm5tKlmmzDvxykhjXtAahnY24hMhcwI+5x2kT/7OVE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l+GiPyjTVvgL+q5X17ULfaoo9sbwXQBFAoLHs6jtDhBPBHCs/z5/4nYLK5IjR8W1AAldDqtRIrUje2cAlvYGHx+Z1d8b/TiBQ3eqx+opcvXH5tNEKBfRoprnEuY6yuRxe+dO1W1V0cn0KaKrOZ4Q/J/LZH5B8a6+k/0mL8r1S7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vq3Jmpyh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a0e4b773so159576566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251660; x=1715856460; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rUGSw1BOvy4nSCnLDtXwjmmz6sz4Fg4JvkDjn2tH+U=;
        b=vq3JmpyhZRc3TR4cEjBGRDbyb7flDs1B9zCrNJi8ceyjfew37YYFlILBv7Y4aOX3NN
         QzeIZuLN4JjUglakAYoh2qa0uWv7E8ZsGChseMCjfvQCU6m8CaERDYjKiFSdtJNOTH5T
         9QdlQPQJuuM3+22NubkXiFgC4RXmot0Awl+etVOpw6Q/UePzy2Nhgokt5n51Zw+uXLW1
         fApW7tHj88rCSIlbqk76hpwS6MdMl4h4JKxU8GGOwur7EwZOIA1d4LhZecY5Z2dg7lNf
         Z31Me0l785CTrTJ602WjYqgMDTEe6z5NHLEuQVyFmydKASh2Eed5LrWKebbClikTIlu1
         K/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251660; x=1715856460;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rUGSw1BOvy4nSCnLDtXwjmmz6sz4Fg4JvkDjn2tH+U=;
        b=p06HYFYhp/vq+To556tYeyZ6ITeVZ7A9vfyfuC5fWIltD0lYSSuj38kosenUpDULBq
         eKqlVxmcL8P14qVicjQfcDdc9fRn6QKmf1dzuSp39J68TwRDOimh2XB11mwk/AjbuCI7
         Av0ybf2OaWfxeXO6EX8evgu1TjGIWfrUN6RxvHFO+XKVI8BfvP3fi75ueCoP8lJIEERB
         mAdTv3L7Mdz59ZaHO/nr2/qWPuelPnvGKN1eFqgkG2hQs9WS7hIJA3TzYcqkAec/nt2/
         aQAdoQeQChctcxEwZ5ThFtkhMrl+dbVyOxudXzerWnw5dGTxxROWCJ6FOD7bfeuXSXPk
         DhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFOMH+fzl+tuUXWqjKSSVRU0ZvtPC4ReOBO16BGfjgm+phIsl2xcmmSWL0GrUFGlVbmfu6V51JZELJHImFJMl8tfDJ1NPEjoH3gA3x
X-Gm-Message-State: AOJu0YxQLtS5QtCtrUZa7NV+CVXmu+WcKMIlexNkUJ2vJZEp8tHIOGLr
	/M5YKb0+MI5vvcPkkkFqypGJKPU4CEDiIWl78tU0sSYR4IGq5qFVY7F6mHSQdEQ=
X-Google-Smtp-Source: AGHT+IH93eb6t4ZGZhsfBVUwyJEUTNQ9gpPokGEI/RTskChoPPUKWX5A9Rf3MAwsN76xfbFTLzj1Sw==
X-Received: by 2002:a50:8d41:0:b0:571:bed1:3a27 with SMTP id 4fb4d7f45d1cf-5731da9edfdmr3363456a12.38.1715251660386;
        Thu, 09 May 2024 03:47:40 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6bfsm564708a12.28.2024.05.09.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:47:40 -0700 (PDT)
Date: Thu, 9 May 2024 13:47:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 0/2] NFSD: prevent integer overflows
Message-ID: <332d1149-988e-4ece-8aef-1e3fb8bf8af4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a potential for integer overflows in svcxdr_dupstr()
and svcxdr_tmpalloc() and XDR_QUADLEN().  I believe the fixing the
overflow in XDR_QUADLEN() would fix the bug, but it's safer to be
more thourough.

Dan Carpenter (2):
  SUNRPC: prevent integer overflow in XDR_QUADLEN()
  NFSD: harden svcxdr_dupstr() and svcxdr_tmpalloc() against integer
    overflows

 fs/nfsd/nfs4xdr.c          | 12 ++++++------
 include/linux/sunrpc/xdr.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0

