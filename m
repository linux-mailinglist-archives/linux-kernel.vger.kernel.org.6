Return-Path: <linux-kernel+bounces-380702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1728D9AF4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D045128282A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578B1AD403;
	Thu, 24 Oct 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28HNKywY"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F051A76AC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805701; cv=none; b=dAsfjS/mxVtK/Wa9ORnGM5/BtVGuHTlW29ihuIyynX6JFkbsg81f4Wc9n8j2NWujlKDQhNkb2019xKgl9HVsX+DWtSgB9BmYmukU87FdBbYfGCSB6TayzXwpMmOa9yzreDt5LhCIG03OLf00wKmit4g0eOYLaYSa5zenl+STEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805701; c=relaxed/simple;
	bh=8HJhFxyE1niqaPSLshWSHKw8RQSQcWCeF9FiIEMH9BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB80nWmWZjXmcbuVKUV5fNKbSwGeeWI7E6H0OEdqe5q/6HlxruaPs5loMl6Un1cJ4ZC/LVzHw5CcI4Kdi7TlUgfvFqKUhpZHIXZBcsXdb8B33zo2skvSNFczAsI+wOK75spLt3oGQGXgrp8y/v2FuBsxzh06UdDxS3qGoAUVFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28HNKywY; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a47fd930b8so428828137.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729805699; x=1730410499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HJhFxyE1niqaPSLshWSHKw8RQSQcWCeF9FiIEMH9BU=;
        b=28HNKywY1j3M0bJ/BpwQtf1ZjAwgDscy+zghDRL95/wpFw0/f9lcEay+eLf2f+VlL1
         VV+yhRAYrGvVCuS2fowxpb4DM6bU0Ay4A4QTCWNvVY1JgbDPwqRhC85tkZOfg7KCdDm7
         u6mUhWzpIpSwwFrUcsQWfn8qNUcpUh5y9LFgiRY1nmddlkESVDsAC1fANIrKtKyC3ioL
         2C7ozSws/vwZmMSrdaCSU3o4HUTbfMWJ+jpLUo1VWECG0HEgJonhhbt1X+Mkp/Yy4zBY
         3ywmXU0B2tKIEtmyCZwVHuVHOZDo7Y2b+fIJo/ns+wcDs3u2OIbs5Pp51wACQSXvdYpG
         rnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729805699; x=1730410499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HJhFxyE1niqaPSLshWSHKw8RQSQcWCeF9FiIEMH9BU=;
        b=BxRK7r2QaKSr7PzFMKPeEpPpnw+Gfori5oHAVKgFVK/PMmIWIxhvKZFl7/YQUBhYBi
         1KSo57ObdFNG5h2IFD8OZf/xNpv1g7hBc8M4VXXZch22WNcKaGVQQY2500m1YEvdHYje
         TZmw/PCkKwAfTvoEamMvzpvPA6/pWqbnQXcMQ1oYkcSV2ApFZCrcjzGO1yqDJ26ghUZj
         ljqvsZorJkM+syZ+ae58vPjyisIzlszoICEmZazmmcWvR5Z4ui72jF5czPqtdrG4g4jk
         C5okikr3WnDLWLKNPJVLTXtfaXMfawECaCsLUpty6sWVXa8du/y8I3ZFaJwaMH93iYY1
         gtCg==
X-Forwarded-Encrypted: i=1; AJvYcCV5jGZ96wCHZ1NDJnPJyodRV3O3EQ1vfl1RBqojuHlitb42cUV8CiybwEGP8PKu1yCl5rqrSecoF1hLbKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4DBcLCsW2IKjNLByeApDhvaEALouRMtLmFlXC84372aKmjdB
	bWWXfy3r5W3LHl5eQCbgX5ucqbOMeDN25vUt4gn8vVogczrYDb73X2FG9CSHM1Rr+TD3by9ZwQS
	pcivKO2xu2WPBGyEXc7XhebE46f5YJalOzKVx
X-Google-Smtp-Source: AGHT+IEgImX8myCywWp7XoCWKbGNI5c1o2R5BzcNDzWN5iUCiaDxo1vXGytaPpvTdh57eH+7o8lcsaK48tV8vseJcw4=
X-Received: by 2002:a05:6102:374b:b0:4a4:8b30:53e with SMTP id
 ada2fe7eead31-4a751bc7185mr10100478137.7.1729805698731; Thu, 24 Oct 2024
 14:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024162318.1640781-1-surenb@google.com>
In-Reply-To: <20241024162318.1640781-1-surenb@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 24 Oct 2024 15:34:21 -0600
Message-ID: <CAOUHufZr3m4pOrTK3QrhdBoRVxYeaC87bptxLND229G9nLGd5Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/codetag: uninline and move pgalloc_tag_copy and pgalloc_tag_split
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:23=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> pgalloc_tag_copy() and pgalloc_tag_split() are sizable and outside of
> any performance-critical paths, so it should be fine to uninline them.
> Also move their declarations into pgalloc_tag.h which seems like a more
> appropriate place for them.
> No functional changes other than uninlining.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Yu Zhao <yuzhao@google.com>

