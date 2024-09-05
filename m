Return-Path: <linux-kernel+bounces-316503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199396D06C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED59D1F2540D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A380193069;
	Thu,  5 Sep 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtP8fIhS"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E51925A5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521510; cv=none; b=chF8Zid/aC/YlpXumu//hMu9x0iePtWzxnxPhqgg97L2oixrSo7L6Wqh9ctUhpsM2WUN8eRU4V1aGCVggozekgf3HYV8nFW3FTPu1BSA2US9Cl6bdQQ8smOaSCk/eyKcJ8fRLcJRQMuJTnK1kShKZWO5dxID0RafYcey9pmM/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521510; c=relaxed/simple;
	bh=ADozzuB4aXAsuItXnHEmYbzuHMSTGkfXgDDLW7TyJfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Kt5PsY5yPCvRben1rpMy+FEZfiGW/F/mniWoub8xOpGr86Ln6qgieJqeKApu67tAWKZxopsbobL62Hxynqy/ywQ0/9WH3UQw5UiKFxx9wLkCGaoWYpDBm9Beh4d8r+BSwV/pbSpdu3Tc3FlvrCF+524XB21DHORa4WywX/g7JUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtP8fIhS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86c476f679so61526266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725521507; x=1726126307; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxpm/KRBSaCmPVGMswzvV0ymk6YQb+nmcLd9CWhDjf0=;
        b=HtP8fIhScVJLACejSe5j4c5KRBVl8FqrrNxIHkEOpwHrNHdDNN/FyauWea7lEAoBJe
         zCvetYMgJcqpvrdPolY92IVyGWRCJFo2qnsyQrMoguT6ttB+dA1exl1euxiD/TQ/E5vq
         o/Ok0jUEmsd3Ynb106rocKWbfr2SYtX2qYig2cj1F+UOQTFjg77gC6giGKnKL5cGuMrh
         8tfnZUoSv55vLiflYhhswZK8x2lGf0RrxwzJn2qvm4bFQTbjejpwjkqLNMEqCIy3B3k+
         N28TYDj9myee7HMETIs1b71Dowr9Av716K7jlDBKJQpf2BbWwZFRIyaV46UAJqiDPvuL
         PU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521507; x=1726126307;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxpm/KRBSaCmPVGMswzvV0ymk6YQb+nmcLd9CWhDjf0=;
        b=kwDsH9yPXOSvtCpMj7lC6pWR8gcCyj8UXeZpxCz28INaNGwZjpi+kUflHkpEtjbvPM
         g18K3kC3EpUJrji9MWrKXi/3yomgjuHjdG/V+sl6Q+RizuiBE5ELiSw8aFRJ7gYIzyE0
         owA93Hx1y3ct52fUL3cf2vFQIKYykl98SBr5HBlo01SXiEMPQXXh7yEOuKaqtVxhOOuO
         mu3kdkepJqNStH33jJl5YijAUeWLBvy8wbi9mq60/hsZ0hSaSvgaVEfR9I8nMzhRgz52
         6gI/xC8u7YuIjaOS6sU5eLeL6tUS0WH3HhgQM5b5OjNEKHLLS+Ll3Nmz0x3CXPsLzrAk
         7Pjw==
X-Forwarded-Encrypted: i=1; AJvYcCX8spSDQnRxXkeUhsa3QFl5SJPo+JmQcP4tcLXqwWCWv8LZolFG68e3mjjNGkZN5Go/CgxE3agQATCF340=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlT4IHecexP+V293gxB2fGCXXunz952Ha7gpZM5WM1TF8Encf
	NIaq23yUQy8jDDyoq2MxQ/WF4pap3D5tZw8haXGbWGPJ1TNoY6D8lDrJQ962CMDXvJ2TJDVm077
	ifnM6lfIq2uCbJHDQi6QbgoP9rkEG8dXyNM+U
X-Google-Smtp-Source: AGHT+IEckPel8FsVowyMgk8xK56rxIzk+362fVdZDaK+Gg3yRWkT+ET93Lk5H34vpbOwuDYazBwewCWUcH/bDNo10EA=
X-Received: by 2002:a17:907:6d02:b0:a86:a866:9e25 with SMTP id
 a640c23a62f3a-a89b9727ea8mr1341691766b.56.1725521506371; Thu, 05 Sep 2024
 00:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904162740.1043168-1-dave@stgolabs.net> <20240904131811.234e005307f249ef07670c20@linux-foundation.org>
 <nwutv6cuuyajmakiiznb3hoao6jfhrs2clpqi76xomqbc6yymg@n7inzwjcskhf>
 <20240904181543.02de2242490cf233c7879697@linux-foundation.org> <a2fdrnaagcgp4hllalttaxs7ckc6w5bt2j7fg4upagqhfvoc3b@jsmugftxvyyz>
In-Reply-To: <a2fdrnaagcgp4hllalttaxs7ckc6w5bt2j7fg4upagqhfvoc3b@jsmugftxvyyz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 00:31:08 -0700
Message-ID: <CAJD7tkYe5xJjMw1KtHRyvCLeGKBgZpU1RNzb_Y=c_NujioYXnA@mail.gmail.com>
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, mhocko@kernel.org, 
	rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	almasrymina@google.com, roman.gushchin@linux.dev, gthelen@google.com, 
	dseo3@uci.edu, a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:35=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net> =
wrote:
>
> On Wed, 04 Sep 2024, Andrew Morton wrote:\n
> >On Wed, 4 Sep 2024 18:08:05 -0700 Davidlohr Bueso <dave@stgolabs.net> wr=
ote:
> >
> >> On Wed, 04 Sep 2024, Andrew Morton wrote:\n
> >> >On Wed,  4 Sep 2024 09:27:40 -0700 Davidlohr Bueso <dave@stgolabs.net=
> wrote:
> >> >
> >> >> This adds support for allowing proactive reclaim in general on a
> >> >> NUMA system. A per-node interface extends support for beyond a
> >> >> memcg-specific interface, respecting the current semantics of
> >> >> memory.reclaim: respecting aging LRU and not supporting
> >> >> artificially triggering eviction on nodes belonging to non-bottom
> >> >> tiers.
> >> >>
> >> >> This patch allows userspace to do:
> >> >>
> >> >>      echo 512M swappiness=3D10 > /sys/devices/system/node/nodeX/rec=
laim
> >> >
> >> >One value per sysfs file is a rule.
> >>
> >> I wasn't aware of it as a rule - is this documented somewhere?
> >
> >Documentation/filesystems/sysfs.rst, line 62.  Also lots of gregkh
> >grumpygrams :)
> >
> >> I ask because I see some others are using space-separated parameters, =
ie:
> >>
> >> /sys/bus/usb/drivers/foo/new_id
> >>
> >> ... or colons. What would be acceptable? echo "512M:10" > ... ?
> >
> >Kinda cheating.  But the rule gets violated a lot.
>
> The only other alternative I can think of is to have a separate file
> for swappiness, which of course sucks. So I will go with the colon
> approach unless somebody shouts - I still prefer it as is in this patch,
> if we are going to violate the rule altogether...

I also prefer this patch's approach. It'd be really confusing if the
per-node and per-memcg proactive reclaim interfaces have the same
semantics but different syntax.

