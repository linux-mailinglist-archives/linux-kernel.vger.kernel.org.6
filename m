Return-Path: <linux-kernel+bounces-370207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993499A2963
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557BC2817AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABA81DE3CB;
	Thu, 17 Oct 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZumqqNE"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53291DF755
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183464; cv=none; b=gyHCRKTyWRwlSvHQ4+1dCo9qv76vknaVX6uiueEBSKg+TvL3oi+l2urdfH7kLTCf8wU0qD77AZf5AaM0x9d0kjkz/7wjJ16isM2HmS3ZKzMCKHhAq7r5d/4giAGDvct730vt/A785IHpxTO4CWMWW28L2ds+tu8/dqbj0wROPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183464; c=relaxed/simple;
	bh=qYmzlCRl1PVunQMKxtFza9iHD1OMsbq9k8HKpjfRrfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuuAAtWm3e5y1kWcIaW4ZK3HSICtajKgQFzCl1wFPioMFsKI+pkO/xT/J5ejrx2nOsKYtke2ZcctlXWr5pXeyzR+EADS8C55UiZHfcUa0r/BkKfkQQGPMeWbDYmhyiG7pIZg8aibMOk+OyWJKpEk36E961oC7bFjob6hdQeYocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZumqqNE; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so3635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729183462; x=1729788262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYmzlCRl1PVunQMKxtFza9iHD1OMsbq9k8HKpjfRrfg=;
        b=fZumqqNE3MJ276zfoVOCYIRwCXkqQrtFN9s0dugHg9KGudwfc+U6vGOd08q78sPGir
         M2ohdVaUwqboCoNMNmKYVZGNWW/GI1JEsUA96rZMCxckSZ09ljQN6CVetas+cnp08d2E
         T1zsp0cEOR8F1gOvJLnzmnNHUJa60ITR7aUvnqyqKnwQZ2QD19VfXmZDb08R9r10Wplg
         1tMf0Rm5Db0EQRt2+pTgDXTgsmpaBo7Hbp8M9CWsXkrmVAjkWdrxqVn7DMp8d2NZ2CZ/
         WAQC6gXs/yOnTXKJObvfMJXjiocxh514M/rYTw595pt62ylt4vX9jopmUGS2AdTT6wkp
         BkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183462; x=1729788262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYmzlCRl1PVunQMKxtFza9iHD1OMsbq9k8HKpjfRrfg=;
        b=uMooTOjyMMngk7KHSNf8Ouinlux/Aab8KCzXhy4sK2Asyrkza7r1TZF6BzesPQAfck
         hWKB3hgNBCMldVLWbb9HDJjMvmgtpClfXHOtW3iMhfhslD6b0/3/on4KHF4GIE6sUU79
         dj6ym2OVzFm3yHD0vOrjCpRC1lgogMsyngS4nh0A+iV51iuIixVsksCH1q1PlKTBtnPY
         M8tdCzN7Gg+xDyTLT9jHONi4+m9CWt0ycINg0H52SDxAxOsD9GKPz6dybMIYsNRBEn6a
         JgIpHkS1XvB2RO+wyz2n7XGCkL5NmEl/SsPY50joRrfEnbWnY04R2YSR9jIhlJgXUatU
         2sww==
X-Forwarded-Encrypted: i=1; AJvYcCUaA50Fl8iZxKktzqBAfSrmLUBAkD/W/eojY/SCeeSO7uxKcNNMqf8aBx0LtbtdBFOjeUwCsA3/jAl6agg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCIa0q3PKrgm3nMkjrntbTvbgY24Q+jU89cqwZ/VqePs9eZoz
	xHcYT0P8c1L5A4NDVJOx2CFWaVMZjEMxsqiRfgYAwOUXQALXiHuW9MWWtKK5e8Mn5TS4VPeBWLJ
	l0vCQYdmmnpOGdVQ3dGHC6cA/HRsUamCuE288
X-Google-Smtp-Source: AGHT+IF2iP9+1oOcV8IGw97zuOm8z5d7mrOyrhGfJCa16rIeNXkwZW72QrTI3RPHM646dPWp51d/P/WO7EK51xoHgto=
X-Received: by 2002:a05:6e02:144f:b0:3a0:aa15:3491 with SMTP id
 e9e14a558f8ab-3a3ea04c540mr4795615ab.23.1729183461837; Thu, 17 Oct 2024
 09:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com> <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
In-Reply-To: <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Oct 2024 09:44:08 -0700
Message-ID: <CAP-5=fWMkF-z5t6-Oz8e8YRuW0rsMg7JXj4vSHqLZFe0y3=sUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, 16 Oct 2024 10:53:42 -0700, Ian Rogers wrote:
>
> > Metric thresholds are being computed for CSV and JSON output but not
> > displayed. Rename the color that encodes the threshold as enum values
> > and use to generate string constants in a CSV column or json
> > dictionary value.
> >
> > Add printf attribute to functions in color.h that could support
> > it. Fix bad printf format strings that this detected.
> >
> > [...]
>
> Applied to perf-tools-next, thanks!

Sorry for the trouble, could we switch to the v4 series due to issues
on hypervisors with not counted events in CSV output missing a column:
https://lore.kernel.org/lkml/20241016215139.212939-1-irogers@google.com/
The patch set drops the CSV output metric threshold support.

Thanks,
Ian

