Return-Path: <linux-kernel+bounces-207844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E961F901CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60AD2825A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17096F079;
	Mon, 10 Jun 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BoACHtEm"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0413BBC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008139; cv=none; b=gNpwbwshoKWbCNMXw1SkCsARlEPyCn5NG2OfqBviCGhpB2L59v70+Yi0/A/AJGn9ALxsVylSOjrlvBNNwSVdurZnbuFMIdkIn2hvA0DFvxlP5395IQJB39mTSpiVZqO4OhRfmGUlgAoJWtlAqRXdGoafqPov9w4xyz2eZH10jII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008139; c=relaxed/simple;
	bh=939idIW3iUubqcYM5q5pS4Y7ZHwRh013h9LSvEp/ihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Lu3jLRF01MP2rSy841/hRQ3yE3KdKLdQacFmdl9z816wH+FR8u6dOR4pTzyn/qU1FOguLtbWON8dNvvrH6yzW6uRKtZsqyf5JqnLbBN/Y4vSpWqaGKXGii5qb0ZPPQir4kuoEqnYaSmUiHfwaQo6kdKQz+CDKpIuJDEpIbb7miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BoACHtEm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so176218966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1718008135; x=1718612935; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939idIW3iUubqcYM5q5pS4Y7ZHwRh013h9LSvEp/ihs=;
        b=BoACHtEm/A8T+JrzGpXG4xuebX6Bc02or4HoZrT0ewQlUKymwNehZ/6wlo2OdZP8zJ
         ukmcuJXKIfsHQvKjbXgxYHF+sycGvwRTZxABoEqfZt0BlC952vm8T87JUYfmRRluQbB0
         O7KUrIk5bBKDgVGVNuEryjR1Id4IWgfTDDdLyB0FS2rHAFiNlpfCbv7dfGJaOv2JzhjQ
         ZnD63whKZxbAll8mCOj7nXhcDKLYqxDLpI7O5S9vu79RLMznzsC38VAq+EHEQoczqlFc
         ZFPlMiyoGKzSV6fWSilwdD525mNU83L0uQZ1Kl2rtmvmB5DyJqXIG5B9Zs1dDh1nR1mR
         AUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008135; x=1718612935;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=939idIW3iUubqcYM5q5pS4Y7ZHwRh013h9LSvEp/ihs=;
        b=OH9l8yKkxGwTklGrUkRXeODE8ietb8e7eRRqKw08deNHL6T1lWW3p+k8ayRFcJ5Zzw
         jH254bnKguZ6q3NCcQfDkpwVhyuGfQ1jQ3nPWrOETzMIyrRYFU/bhFXMCFFUEHdLLAkF
         3qgHbpx/BeS5ybHBjsxFX62rwSE2r0RC6jT+/6ouAu7evN05t+blwtePetArb0IJqlYa
         /n96JFPV9lDUo92VfGRx98jO4T/8V6JqrYHRgUU5MDi7rCNXUZ6vQZecnQj3VduVwDCw
         I7+1Vfdrpo9qUxjJJJT1aD+0lkQUp2X/y8292XE0lM6u0tl4S5Jofkzh/m+Nfx1BbZIi
         qjxg==
X-Forwarded-Encrypted: i=1; AJvYcCVoPGXDIOTieYPyQck/S8WM28frv34k4eVCnhXLrBN5PyLMzsQ4h5Q3xXp8HS84VZswB+cjSID8YHT44RcbkHmwvlLyFgMyugCdkUYJ
X-Gm-Message-State: AOJu0Yyz2zUQODWvpoXHpNG+zzvaobRLA03hhsn700GBDCH6iIew6Y+9
	tLUA7l5MikoZ+6mS2TTrD+rF5fxe3S4j8Xuseg7LA0EkiD2L8kF1kq0BzR8btk+7Z7JmUB8bcZZ
	8xbnfxT+X2CgzbbY/vf0vwe0g+NjUtXu61Mah135vBdJxU1J0olM=
X-Google-Smtp-Source: AGHT+IEAkeujwQKBhYRjerusld3RiXkjqZSWWJJO4IZwmGkOuMOsGdNlacEBsMnqERjUgwH37hXZ69TikhOfP1/qoew=
X-Received: by 2002:a17:906:407:b0:a6e:fbdd:1066 with SMTP id
 a640c23a62f3a-a6efbdd11a5mr354806366b.67.1718008134905; Mon, 10 Jun 2024
 01:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
In-Reply-To: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 10 Jun 2024 10:28:44 +0200
Message-ID: <CAKPOu+8oS1qn94R1f45CW2MMLhvvE=t7_vPtvq==CiD6nAjscw@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Johannes Weiner <hannes@cmpxchg.org>, surenb@google.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 9:16=E2=80=AFAM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> One of the servers is still running with this problem, and I can
> access it with gdb on /proc/kcore. I'll keep it that way for some more
> time, so if you have any idea what to look for, let me know.

It's been a week since I reported this kernel bug, but nobody replied.
I will have to reboot this server soon, so this is the last chance to
extract information about the bug.

Max

