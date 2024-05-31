Return-Path: <linux-kernel+bounces-197492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B58D6B63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D7AB214ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46DC12FF83;
	Fri, 31 May 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9eQAr0c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBD12F5B7;
	Fri, 31 May 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190046; cv=none; b=SWiJ56uJdk27UE2wrvdtZAgZGQV93F2Cczxp0/MTVNjCFIoHWEMDNCf29Hsw+iexNgmy22bq5DQrquBDP2/6+iLi4j9GPp6MVOrYbfjnR+eanNUlfufmkBdtCi+Uu7TjyYHsyKgIKsWUXuyvFa1FrkMUCJ772FzumQSVV1pOKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190046; c=relaxed/simple;
	bh=g4xGftAItbPB9/XxDsfBwBbndVWd87MNeTmFhogkhE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DM1O4xBb+ffgnRA0jUaZ01vaQ5EQtzY67bTTj/tyoOezYsH1wHdhTFGtc66f1wF0DuX4h+KXRoAAmXipGCGHFt9oqpa97TkCZenVwUAhSAalKlY9azlQwwtGlWBYb7NJK3FowdwhM/jLLbYvjBb5o7c7rTGbwdC9DTehNjMQkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9eQAr0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0F0C116B1;
	Fri, 31 May 2024 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717190045;
	bh=g4xGftAItbPB9/XxDsfBwBbndVWd87MNeTmFhogkhE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q9eQAr0cmZto6gpP+2HJ1tgAKR9hzD+P9Yx0I+7h3WffpKxyQny84HXuFZcA18tm6
	 +1cd/Zurjeb9aRuEvKekL6EYsLcgAqF9Z+IsFVxcecXTbiZZBCfiOf52kWEt1BS//y
	 AQSVa8+Y34ZgO2LPifHhLKsP63HnmIJTw5BTKpdI9AruvHdci43Amew9GO/tm+x4Zg
	 HA0XWkBlHu3tcxNS5gkSxcYsxHcRXuk16Up5XhHIfWm3eTiZ0Q+eL00ro3hO9tmqxF
	 /1wEvpZHjR9uROFbuF3jY6J3sKJb5Ei6fuLRvK12F2GygKdW9Uf32uLAKakH9ktxxO
	 GQntCGWGA0WBA==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools api io: Move filling the io buffer to its own function
Date: Fri, 31 May 2024 14:14:03 -0700
Message-ID: <171718991317.2179562.7793120859292708141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240519181716.4088459-1-irogers@google.com>
References: <20240519181716.4088459-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 19 May 2024 11:17:16 -0700, Ian Rogers wrote:
> In general a read fills 4kb so filling the buffer is a 1 in 4096
> operation, move it out of the io__get_char function to avoid some
> checking overhead and to better hint the function is good to inline.
> 
> For perf's IO intensive internal (non-rigorous) benchmarks there's a
> near 8% improvement to kallsyms-parsing with a default build.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

