Return-Path: <linux-kernel+bounces-299843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211995DAB7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FA01C21043
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F425745;
	Sat, 24 Aug 2024 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ORW8temI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237A1BF37
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467492; cv=none; b=YHDLBI+axm89lUO24moEhfiiDFlf7Knbve2dzmcD5r+wb2iteYpKqtS65abqR7go8ypX2p9qWizShczYqkCzLX4R0Wzas6VQ2KEegDUNvUN0kK5cbBK8C+6ZHXP73FDqVmHwzj/tTZ1eY0bkh2IJ5iM1emZr/pkxej3XKbMu5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467492; c=relaxed/simple;
	bh=FmoDOB0OPTck8xKQCLXd63tlHQKCInRr+0shW7Ri8xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUHxNSXdSBTzg+RGikowHQ5xXvank/SlqITC9jtCckeAYKFdl/11ntjR5Z1txKtv8XwkYi7/FBCLZBoCRquAVWlGf5m0CrKA7w7MdvpocM7XLreTaJzsxWeZSN4M978hlRv49b98QLuXeUfv/lPDLVer3ouF6zOhglJ5C7qrYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ORW8temI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928fso27058145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724467488; x=1725072288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GUvvL47Mo7n+lywss2Dad0TaL+XXqumRNDXQza/86rQ=;
        b=ORW8temIB+de6aRFfuzdMVe3gXF6TSk1JovkxAVnJJzamgde/OJIPAUfmHQNYTo3n8
         U2Tg3AZt9YsJyaE+MW9K8w2BegyQM4s1SXjsrpvRZM7j25MnpN2dcBGWmrYIYbTSf5LV
         WaRIugzZUWcjvq7dDoC5MdO4HcI71CMgqLxsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724467488; x=1725072288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUvvL47Mo7n+lywss2Dad0TaL+XXqumRNDXQza/86rQ=;
        b=nS9+uHyMYuYxMJpyYlVlgBSR4lQU5j5SQHKf7AhluKr1oR6CBtW59q1bM0MbeOWWqc
         fAX/YTS+Xys+nytATI7mHHfEXstIaSskXvXs7ZJaLyQQpBfm4nVgUzqWHzx+pfF4Hd52
         +xz4Ck3/mOLfYfgufJPo0xMM4Ux7zi6vtCwuEmdgFMfg7UWC/XXQT5WJTrlHpTu7ZkRY
         EYxjQG3WM0ajt88HebXvn9uzUnz0hLvIOKnBgOB8FzfNoOSe9hvIOM0yZDR8Qd0mqOBN
         eAycK9y7SiAH6r226HGOWZpKhEGcBOZrTDz14Zs37gsApMLwzxfmGySCkUg+f3OPkfuB
         7GqQ==
X-Gm-Message-State: AOJu0YxIo9SyLw5GqXg7JOOEpl7P019+9TY62HnqEhrPygE/at18fV4T
	7Z3UBf5ZwS4p9jYqyktJ8yj7Yp2NdaKQ+FWRVXf4w7oKM6X5l4zTwcL9K90GfhwjRLBLv14bHgk
	TMxScvA==
X-Google-Smtp-Source: AGHT+IGHI6mxU6XLehW0AHLkPAdt7xZmga39nQyVU6gKUiRgImTp/ZEnd3AsDMDYWl9xmLHIQAZgrw==
X-Received: by 2002:a5d:58d9:0:b0:368:6564:751b with SMTP id ffacd0b85a97d-37311864454mr2864705f8f.32.1724467487878;
        Fri, 23 Aug 2024 19:44:47 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f5c3csm340304266b.205.2024.08.23.19.44.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:44:47 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c07eebf29eso1066539a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:44:47 -0700 (PDT)
X-Received: by 2002:a05:6402:26d3:b0:5a1:2ce9:f416 with SMTP id
 4fb4d7f45d1cf-5c0891b4825mr3488180a12.37.1724467486946; Fri, 23 Aug 2024
 19:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZskwWy-gDniofgyx@slm.duckdns.org>
In-Reply-To: <ZskwWy-gDniofgyx@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:44:30 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgjnYfS7pqZ5Mj01H3Y3HC1F40ZWsk0kvh7QMTZ57qqRA@mail.gmail.com>
Message-ID: <CAHk-=wgjnYfS7pqZ5Mj01H3Y3HC1F40ZWsk0kvh7QMTZ57qqRA@mail.gmail.com>
Subject: Re: [GIT PULL] workqueue: Fixes for v6.11-rc4
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 08:59, Tejun Heo <tj@kernel.org> wrote:
>
> workqueue: Fixes for v6.11-rc4
>
> Nothing too interesting. One patch to remove spurious warning and others to
> address static checker warnings.

Was there some reason you sent this twice?  Did you perhaps mean to
send a different pull request rather than repeat an earlier one?

                 Linus

