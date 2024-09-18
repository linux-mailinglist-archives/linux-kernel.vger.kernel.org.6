Return-Path: <linux-kernel+bounces-332655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF197BCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DB21F2356D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C2F189B86;
	Wed, 18 Sep 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I5czZ58y"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D77189502
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664445; cv=none; b=OXmHcGWSGQWYvPMQ2BnSnqYSKKO556PgZpn0hpnZtDKthYi+DW+Nlbp81uW7Wndfrt98uwhJ1xdTgUihUpyMldqHtYqgr0kpRfEY0sQ7xP/B7eBLc0Xgmv5HoLk4zIu0OTz5XnrctrH6rGgC2GOItBARspf480uSkJZEaeB9S6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664445; c=relaxed/simple;
	bh=7oYarAgQGycazDkvkKC7WBcvZUwjYr8rRIgQCtcjAvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjJhYQ3U0HEuQBAABl1RqSd1s2InOE5RbxO0j3a7aTUp6mNaRUkRrwJGXANpxpZg31e9nxX8hz9xdiz0cyIODtpagu/mwlffnxILJwh6kevp0GNvFTeDt/flfk5l3SBlwjKnzOe5GpZl4DWEXndkB+PVZPmgYXDOXr6Md669UCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I5czZ58y; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6da395fb97aso53820807b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726664443; x=1727269243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTFCOs9eRo+XyG3ykCf6buEoqWSg20vB347/PrvRrnc=;
        b=I5czZ58ykAXU+xZuZjxkzz2GtvB1lnoeU/wYKqNAETi+q6A0YO7MGvLNFEEYPg8lzh
         FmVp6l0MJ7NAIbA3xI5KvRjOJLxM2kdVuuO6LP4fM1A09MHNlBFYV9igT9+ndfcyuXgF
         M/n0m4I2S2VJ+/V+DuH4aTimogyMBMPmvWTeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664443; x=1727269243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTFCOs9eRo+XyG3ykCf6buEoqWSg20vB347/PrvRrnc=;
        b=KI/lYQGIeP3ABLHO5kjAcVYPqJzNcOUUb1ozNi9+kw37J209gheSTAAabq0uVQvX8d
         AihM6Cp9PIjrtL9K+hf6XIqoKsDowFlO1BMKmK8aLe/6AM9xw7nLP4RDn5mA1UGzFdyW
         2jBM4JgOCM/XIApvw7EGhkeUJYQlgxhVKOrlq5DjBkVs1jyN1RQdmzIP5BtAMpXt0KO2
         BCaWDmVu+2mDdZ0huicX1CmmcPEBzOe49A54FtQ5JfNFoYaIOZctynoZdKX9PjxNGL8J
         nEBWUyZR8zUTT1flKVJmLT779IGT+5kz+vcLYN4rqidJTe1+LvWzvx2lLmQcqJDmTFPb
         I23Q==
X-Gm-Message-State: AOJu0YxXFmHHZJH/ijMtCxNuFUbD7x3RDXmiUj+QUyUO/Vcr7NgZEeAB
	s8VFnTf5kQqNxkVwbJfSdwm+8iKWewo1GrO70KWnLk+GlclDBF9cmi1CargjsVRuY/0VmxcKkQ2
	AoizaZxAcxXLyW/hDlbR+EhlYYvRbqYgYEcI9/w==
X-Google-Smtp-Source: AGHT+IH8QHqnY6rEGJEDMNfkvoA+xM+VUcOpc93lVvHh6R+t3tPaKNjg9OKcTz+lf5/gSA0KXCTLX2am7Z/c20HlVc4=
X-Received: by 2002:a05:690c:f0b:b0:6db:7a8c:6653 with SMTP id
 00721157ae682-6dbb6ad2e62mr180282607b3.6.1726664442742; Wed, 18 Sep 2024
 06:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com>
In-Reply-To: <ZurLc9qEjBH9MkvK@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 15:00:31 +0200
Message-ID: <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:45=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
> Please pull the latest perf/core Git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-20=
24-09-18

This - and the perf events fixes pull - was in my spam-box.

The reason is because kernel.org has made its DMARC setup stricter.
and now requires that if you have a kernel.org "from" address, the
DKIM must also be from kernel.org.

But you seem to be using gmail.com as the smtp gateway, and so it has
the gmail DKIM, and so while that passes with the gmail hashes:

        dkim=3Dpass header.i=3D@gmail.com header.s=3D20230601 header.b=3DGi=
5JkPcO;

the DMARC does not pass, because your From and your DKIM do not match:

       dmarc=3Dfail (p=3DQUARANTINE sp=3DQUARANTINE dis=3DQUARANTINE)
header.from=3Dkernel.org;

end the email gets correctly marked as spam.

You need to use the kernel.org smtp server in order to get the proper
kernel.org signature for a kernel.org source.

See

        https://korg.docs.kernel.org/mail.html

for proper setup.

Anyway, I did pick these two emails up from the spam filter, but I
don't guarantee that I always notice things getting caught as spam.

               Linus

