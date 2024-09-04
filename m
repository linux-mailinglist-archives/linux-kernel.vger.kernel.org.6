Return-Path: <linux-kernel+bounces-315265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FE96C026
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C321F264E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BC1DEFED;
	Wed,  4 Sep 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eobik0Hb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCC1D4170
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459596; cv=none; b=swwksfGErxgXyYWO3LFv8NywO47M8ORULvwVM7tQv/yRvRAdnTe3sGtWZ7rtBCtbAtwv7YXxTtfQbIMnGajDPd2PGSD38qni98tzSw8FhHCkYTqLR4Fz0caMSEaRqP2WAi/bSTBBg9xjGJ9az2L5e4fiDgD8I51Wn7pyB2SonIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459596; c=relaxed/simple;
	bh=mD9f5S4DEuGg1jzc0Ldg5GumyZEVw/s2kOOHo3uEVpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjrpnX+rkXNhCSp8S6KHFeC7sNyLGbKy8gMhN4muZ+GEcC/pk+gbF+xMZcEoPOwwaQUMsTtYL5ShHK8g6uWWQbs8u/JaNg6lVQ1FBQBZ9QWMofgaqQg7rsDVoySYVIIQcsEF3Nnn2gN8ltNOAq2CIUnc4L3Xc2KDwszNIqGGWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eobik0Hb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725459594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuCkigoYy9EvKgW0pYC+K0vaMmgbR7ffC5hTK29y7rc=;
	b=eobik0HbndM/z0K0TH3nCDyIhYHL6Ogr7aBbxcZj9fbDfnyLUji18Q7LamlNS1HtZPZvAY
	lDO7Oa4/cq7keNEKtCMBH3N+3C65meReYZyDN46qyucqoX63l8vz6VPe5hsxcLqLwFvKr/
	juxRs6IQfEMs3nCoYA8pvSdRlEa8/Wg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-YKWEgFUiPSOitQiHk2hTeg-1; Wed, 04 Sep 2024 10:19:51 -0400
X-MC-Unique: YKWEgFUiPSOitQiHk2hTeg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6d7124938d1so26159837b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459590; x=1726064390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuCkigoYy9EvKgW0pYC+K0vaMmgbR7ffC5hTK29y7rc=;
        b=uJ9v0v0c5jVB50QB+9xa4nftNTwXFNYmm5+Op5rJlza3mHFgQYYGMXH5Kf3O4rIq2y
         MA795nLj/rbBTEomIK8ErhDjWUna2vtyt8klb2T8vZWjjW2v/XserBv2TCir+GQs2B4h
         RPG/Q/qZD9qPJqP0NmoYwziPlh/KBpWr+Z0sNpnpoZfTdepAYytrEtncwpNBTUQwv0u4
         lNMVvN54lIpcB1GUcQmnGuA4Bpiy9ozJKHZDKEtUqIBbyREB9dlII2ohnoGHjFb3BxwK
         Puv5xaQopYBs3wyY4foIuGPFG/twOUSRMyjY+suTk3Y4FT1s8ok5oA6kHAmu+wbW4M4v
         P9kQ==
X-Gm-Message-State: AOJu0YwWUiU4oDMW4LmvbmuJZ90wZ1kQIN5JvjFeXZWxhuqew7b/8DJl
	DqSirLIb2lkQVlECAuLCVKfs2GPYZb9k51vmw8fyzs+DoydjxVJQQkgEz1rWarGHTDE7aXERuLI
	JkXdzgDcaImy+43ik6jVxg1ZZcq+sbtQMaBO1N53Bwlb1IohUGiovfuSGrE0jpxlGHwkRiGoVUc
	r/DkRIz4MV4xof36MKDLoJWBLJIpZbzQtVqFfq
X-Received: by 2002:a05:6902:168e:b0:e11:698f:8843 with SMTP id 3f1490d57ef6-e1d0e9eb2e9mr3269417276.44.1725459590493;
        Wed, 04 Sep 2024 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnTbfou/A8LxL0fK6QJXDt09m8CtPZdb3+3imkX+k2RU4I4bqj44gQm96hRgWPBh0aaVGuUjc3PXGEU1/6fQ=
X-Received: by 2002:a05:6902:168e:b0:e11:698f:8843 with SMTP id
 3f1490d57ef6-e1d0e9eb2e9mr3269393276.44.1725459590233; Wed, 04 Sep 2024
 07:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
In-Reply-To: <CA+G9fYv=v713xAFCKvkwr_0qyaQWkmfeDC2=bO7KKkui+p+ZeQ@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 4 Sep 2024 16:19:39 +0200
Message-ID: <CAOssrKdc4rcjJOqBnhbRa=R5yQY1erh+KuXr_2-nGTQ-qk3vOg@mail.gmail.com>
Subject: Re: next: rcu_preempt self-detected stall on CPU - queued_spin_lock_slowpath
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, yangyun50@huawei.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:06=E2=80=AFPM Naresh Kamboju <naresh.kamboju@linar=
o.org> wrote:
>
> The following kernel rcu info generated while running the test case
> selftests: memfd: run_fuse_test.sh on qemu-arm64 running Linux
> next-20240902. The qemu-arm64 did not recover.
>
> This build was created with kselftest merge configs.
>
> Anders bisected this to,
>   # first bad commit:
>     [5fb9c98e9d8ddf2abc645e2dcd9eb6703f77fdab]
>     fuse: add support for no forget requests

The bad commit was reverted from -next.

Thanks,
Miklos


