Return-Path: <linux-kernel+bounces-247226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B192CCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3651F22F74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCD12BEBE;
	Wed, 10 Jul 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLIBhcfm"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2112A177
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599658; cv=none; b=eOn1apR0WZCcAaZiZPR3PVi7QP7U3/k6D1wKWlPm+g5kvVPt54iQaohFB7cVZqa+hIQteKGnAl0uFcE5+24GmqdzZIn2My74SZzt3nW9wGUlZSwB3CuY33CzV1l0tw4d3vdIWPzAO/2Z/3gePHaPMdSEjN7lKmhCQH1Mh4hO+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599658; c=relaxed/simple;
	bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3AFJnsxx1CPUhA+9fnh/QG/fYH19ArgIpwo0ikN5kF+4Ss0PX6jsH7/xkYosL4tfGciZobgyK1VDoSKnmOUiWakLdKlqz61Z+tyUZkKu5kwm3Gh7TzAbcE7RLratPi9hSQpohVY9kEyS4sW5syDt2S70j8wrrY+rqXPswYipwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZLIBhcfm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so84313841fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720599655; x=1721204455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
        b=ZLIBhcfmXNzxci9p7l2DkVuG2NlGxfs2vR3FypWbXi1IxHvgyhsnYPbW4JrojtAk3p
         +r5zzmwqUoTm8tLsIlLsk3DnIaXBSotsziUha+GWSj0L1XVGjQCbkXUe9MYjQREiDtwb
         cHQ2r+ZELLQXV0iS/DjYnaSBVtuTDpnfJmRvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599655; x=1721204455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+RlSDDTSsw+TczheJFJM0ymz3DgCZJKh5AaCvk1b9Q=;
        b=rlsDeNHy9EY7e2vg1lIj1eY0uHhihkLNoLJmA0HwOkUTeJJKiJbG1mHBD5NulFLSp+
         z2HD5C4YF1wzsHleLAH2BdUyZXcoo4sDaZr8tBgqeqb7AUaaiKZ51jqNH4cXisxwgyzV
         E6iCj/3fGbO9G7YisqXMMXDGt+Jj1OlGBATMQ3Y6/Ds5ZJbwFfbs/wgzyP1QtFtL+5jI
         xvjkaGxmR3dPhGPg3zsGPOlWdmjDQYrOyMwZAcSwXZyz3oFN98i9PPqBgM3qmlCQ4uE+
         24dWPA1EGrbvZGzvBOps4gecI7OOMVzn5y/CgCfDRbyO5ojkKwMzfHwR70c3ptkfxypQ
         jlzg==
X-Forwarded-Encrypted: i=1; AJvYcCX1kZ44wt33FVY5Onn/GlEvlnnER9O0cT5LrFwkxLB4h0B6ZJySCn4/9gxYk7zpj0E85IIA+lwWyw81T/U9sTsN7J20fFw4oSEn07iZ
X-Gm-Message-State: AOJu0YxHJWemT2YkwB1k0FWtpSvIZVhnbWcDf/uTRFB027XDQsWDWwrt
	BaZQAo+NonlX5EzSgLfj/aM5vnevnAGe7dXPP+M1hYN1CX4Gr9Zm2SKRIbFbq051kCUwn7CHMdC
	8ZTcV1ydASCUX8y7H6gcvsYzF8eBV+0rTP4s=
X-Google-Smtp-Source: AGHT+IEAq4kkSUgtsxyOH15D6jkCwSRAL31AifedA+YyD0JGizHJjSS3vklJsbyYJkyWrD4JVRnuf2baYIixrqDEEAk=
X-Received: by 2002:a2e:9b50:0:b0:2ee:be50:52d5 with SMTP id
 38308e7fff4ca-2eebe5055d9mr14147121fa.43.1720599655293; Wed, 10 Jul 2024
 01:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org>
 <20240626213157.e2d1b916bcb28d97620043d1@kernel.org> <20240626095812.2c5ffb72@rorschach.local.home>
 <CAH9xa6ej2g+DvCd=cqjj8sx9yZ=DjL6Ffu6aOfebvcjBmGs5pQ@mail.gmail.com> <20240702123747.796b98c5@rorschach.local.home>
In-Reply-To: <20240702123747.796b98c5@rorschach.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 10 Jul 2024 17:20:42 +0900
Message-ID: <CAH9xa6eGynkLNaSixQXOZMDTgi4H8vb6eY8e92aGRnbPPq_pPQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Matthew Wilcox <willy@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Junichi Uekawa <uekawa@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Hello Matthew, I'd appreciate it if you could comment on this.

Thank you.

