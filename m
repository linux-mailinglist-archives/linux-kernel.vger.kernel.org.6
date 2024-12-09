Return-Path: <linux-kernel+bounces-438429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867619EA143
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D521162A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9764619D06A;
	Mon,  9 Dec 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YMTcBcvw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AD143C72
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779855; cv=none; b=Ajk7Bk3Ocz2LvYKeBrTaWW2QKZmGDaOkqlK4DXIXMpm8UxqrjZJ3XzR90mP16Db8Y8mJXzNx/knHSZeqNHjV8E+I5DeJzQsrdx3udxHb7v1trmpDI+KKG9FI8hyPQKauyrhGMNg1tclSPZbi+/Fk9g5RHgdoHHjhjf7GmAnxRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779855; c=relaxed/simple;
	bh=WiJKMTsPf6wLrDfDk0ktMGtROs4LgWJkSuu0oAaTiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqB3AAZTpYjpJ+igJAILub/SqUfjQfjDJajvPbbBmMqH9Hu7M+nxmTS/1EmKs19hm5rYZFvEMrPD8XOaskuXSbyfl03fKPmU6O9Luxo7oq2CZY7znSCFQy14x4w9O3HZaGlLjPA9GdIi7zCgjGShiZx9d9WML6O39XX+EbYGpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YMTcBcvw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc93152edcso3858405a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733779851; x=1734384651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq4bE8ynK46fAtG2+WFAUVPbfKrAMZJysC5gDFoJ5yQ=;
        b=YMTcBcvw7kNuQXnFYN7cvvlc222ZV0BSFO94DlT/SFxiw6vnfdrxbyCmP5AJqlNnGp
         6V20My2YUfMUlwE5ZP+708lekJ3y8HhNGKShdga+YoXPMKAIJrrdzE0VGuIVW31hK6bF
         21+gb9wumEx0WmkbkoiqGzNq5SdjNRGzCCIRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733779851; x=1734384651;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq4bE8ynK46fAtG2+WFAUVPbfKrAMZJysC5gDFoJ5yQ=;
        b=FAWqqx+wlSijKPTr3CBEbIrOeWmRzMUQIbxMgchiK2jssHhOgco3ZYwdAZrzkhCEug
         PFT4BIq57aVm5qMzRuctltz8kHdWwKyw6rrqQQ+hdOy0o1Pck+WkquiGqmBAKPg1v1Qj
         Le61QlDZkryaqPwi6I4oeC1W3J+LPRFINW0cd36dPJsWbqUNEhyegohznmrfNWr9BnJP
         +XGVqev+8DrRVc9bZNQe5uTxRMHjLX+2bMdw7NdRYm9ySSn06PuKEfF0WzFPmJzYPz8+
         pw3VmqbndDnpkCDkYtCP8b4MoYq2XWfwDb3853/TpnXBZw4LQ3KrGuVwUz4z7uKxNSbk
         6zyA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0FY9X82uFPGHzI9lG+0H9Bp15Iai0fQX472zyO5xG0l0yzS6Ja861fTrwJoQ7gLN9t5/NgKNG5u+/e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoWKzbcZLHZznqhBN6J+Y/RuASl4+Qe5LBed3rekU1zRm+09+
	gs9+Hnwn9kXcNg3O6ku6PBK+PMUX33/vrNtXsZgUDZAuqDd3uIhNk2wcv6T3FPw=
X-Gm-Gg: ASbGnctEvh68ko8O6/TwzRjg3j4gMaJ2eugrmIgXR3r1aXkhp8QNyjuL4Q4Xtn4bntg
	/MnQJ7uvaFAYpE5qtnlkXT0SxVynoPMxQynu5OvOl95l1jqt0bxzHEICppOB9a2aqaEL1ykuC9v
	FB7TFn0GqtZ2TUqe9Z+RdqIxin6vGVxf40lOWDelLK/NENJ+lW/zz0jzWAIhsKi+xm1SJXhq+hS
	7eES8RTva3xCYjt42GX1OWjjq6FTCE4GrabjGQMD1YYE6KjcHo5m+u1WAAzX/JuFkTlnR5e82ud
	b9SOIG0Q/qh4J9vBpfN0
X-Google-Smtp-Source: AGHT+IGaQl+Th+1UK4dZouO+Jykv6AjRjKda0D3INprhZjXS4b+yz4fFGUTDReg578joqoVWuKlWFw==
X-Received: by 2002:a05:6a20:729c:b0:1db:e327:dd82 with SMTP id adf61e73a8af0-1e1b43c4e93mr1633149637.5.1733779851414;
        Mon, 09 Dec 2024 13:30:51 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4846418csm2909498a12.28.2024.12.09.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 13:30:50 -0800 (PST)
Date: Mon, 9 Dec 2024 13:30:48 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tools: ynl: add main install target
Message-ID: <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com,
	kuba@kernel.org, stfomichev@gmail.com, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1733755068.git.jstancek@redhat.com>
 <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>

On Mon, Dec 09, 2024 at 03:47:17PM +0100, Jan Stancek wrote:
> This will install C library, specs, rsts and pyynl. The initial
> structure is:
> 
> 	$ mkdir /tmp/myroot
> 	$ make DESTDIR=/tmp/myroot install
> 
> 	/usr
> 	/usr/lib64
> 	/usr/lib64/libynl.a

This is super useful thanks for doing this work. I could be missing
something, but it looks like the install target does not install the
generated C headers that user code can include at build time.

Am I reading that right? Is that intentional? I was thinking that it
would be really useful to have the headers installed, too.

> 	/usr/lib/python3.XX/site-packages/pyynl/*
> 	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> 	/usr/bin
> 	/usr/bin/ynl
> 	/usr/bin/ynl-ethtool
> 	/usr/bin/ynl-gen-c
> 	/usr/bin/ynl-gen-rst
> 	/usr/share
> 	/usr/share/doc
> 	/usr/share/doc/ynl
> 	/usr/share/doc/ynl/*.rst
> 	/usr/share/ynl
> 	/usr/share/ynl/genetlink-c.yaml
> 	/usr/share/ynl/genetlink-legacy.yaml
> 	/usr/share/ynl/genetlink.yaml
> 	/usr/share/ynl/netlink-raw.yaml
> 	/usr/share/ynl/specs
> 	/usr/share/ynl/specs/devlink.yaml
> 	/usr/share/ynl/specs/dpll.yaml
> 	/usr/share/ynl/specs/ethtool.yaml
> 	/usr/share/ynl/specs/fou.yaml
> 	/usr/share/ynl/specs/handshake.yaml
> 	/usr/share/ynl/specs/mptcp_pm.yaml
> 	/usr/share/ynl/specs/netdev.yaml
> 	/usr/share/ynl/specs/net_shaper.yaml
> 	/usr/share/ynl/specs/nfsd.yaml
> 	/usr/share/ynl/specs/nftables.yaml
> 	/usr/share/ynl/specs/nlctrl.yaml
> 	/usr/share/ynl/specs/ovs_datapath.yaml
> 	/usr/share/ynl/specs/ovs_flow.yaml
> 	/usr/share/ynl/specs/ovs_vport.yaml
> 	/usr/share/ynl/specs/rt_addr.yaml
> 	/usr/share/ynl/specs/rt_link.yaml
> 	/usr/share/ynl/specs/rt_neigh.yaml
> 	/usr/share/ynl/specs/rt_route.yaml
> 	/usr/share/ynl/specs/rt_rule.yaml
> 	/usr/share/ynl/specs/tcp_metrics.yaml
> 	/usr/share/ynl/specs/tc.yaml
> 	/usr/share/ynl/specs/team.yaml
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

[...]

