Return-Path: <linux-kernel+bounces-432558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F29E4CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D8F286EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670C1922E5;
	Thu,  5 Dec 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCUKKJzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271E190674;
	Thu,  5 Dec 2024 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733371138; cv=none; b=MNJ60+LGs3lrs4nNaOXY7lazOMforuHhLcIDfN7PLKJ40sGPB4idSf55j2qvxqRo7E3wUXIQLKPjFrLYAZ95Gjw/Kk2Nzbou1QNxAHcGkee8tQqi42ibmZcHdnoj6njWsJpy9/CTJf/5NTPjXuDLcMgPWjFVNcR3BsINNtsss8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733371138; c=relaxed/simple;
	bh=JDaK/7p0eD2vcbuFmWKF07t+VARFhmUlkG/iI34Zd1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzyLqq0cxdOcIRpXKQu/bpcwEEmyow+uhiPABCqJdlhEj8nuWGgS+/J3avIOgkTHw54D3cOoTNNeuxFTXpZej7ih37+qLwqlYHrOkm86unwT5X5dBznF4+TEEKDgsYcOpklg0jx70jadRd/P4vjSgRZIoRY+U5Y3i4mr7rUycBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCUKKJzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C559C4CEDC;
	Thu,  5 Dec 2024 03:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733371137;
	bh=JDaK/7p0eD2vcbuFmWKF07t+VARFhmUlkG/iI34Zd1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCUKKJzFy05gTLwHDgRiU3aVXEkbWLxC8FAwO/3horPX6k6evO30GUXy5ujoGTSU+
	 dyI6PRs90PfWiRR0r8BKplE1ki9l/sCIDsRNwpNWmD3J3QIEcYKRDR0GziKxJmIc15
	 G8oAKvvtDNixj6uO111mQbhYbifbLQNG7nJfL08a4nUFC/YWdyb4KjwTLVlDIdQW5A
	 eqTr7IG1lKRZ2B44fpgFxUKMaYJzXZAz5cLTJiFLqaJFzXsEXyBj41rLT5NO3xqm5k
	 /YvXoUDLTka06S6/N043Qv2++keWHOXTsV9RkRsDhiwaJsRPHEQSASeJFn3S+Y7k5C
	 MGgutbIEbVDSA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df119675dso636475e87.0;
        Wed, 04 Dec 2024 19:58:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCO6qMr8M7eTjNXWm0lffjQSgFSdSbRlHIyAM2/GrqhM9a8U5osVxeMDakynHGKVog+r6QtJJdKS6G2cqj@vger.kernel.org, AJvYcCWREA17wpMxINerVLD87JOmF7BDoL6n9wQC0kp/8gGOYUOp68aDdBJhMsZ2NE0oMYY9mBayI/5XeEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lRvyNEc0AbHn8cnc4e4MEpALKRLQQ/LCRypt1CWFwBCLz7pP
	Pu9SJXDosJYtpN6dZPCcQKP1UGC8lOsFBOM6aaHwkdtqpAuByLgIRocMw41Ka8VYfHV8Ya+0phK
	ERSwBWgNtsSiTgERtD1VGxL3FGZw=
X-Google-Smtp-Source: AGHT+IFIPtu+SFico7VruqjA1JkrXBNoTClZak0HmvZk3FMojUfelsOvmVjG85CcJDrG1AIW6cHqdgIVWUI0EJQNwzQ=
X-Received: by 2002:a05:6512:3a8a:b0:53d:e7b6:c702 with SMTP id
 2adb3069b0e04-53e12a3937emr5653206e87.50.1733371136144; Wed, 04 Dec 2024
 19:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733305665.git.ukleinek@kernel.org> <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
 <87mshb3f8x.fsf@intel.com>
In-Reply-To: <87mshb3f8x.fsf@intel.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 5 Dec 2024 12:58:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMufXP0EA6QUE9hBkZMa6vJO6ZiaYuak2AhOrd2nSVKQ@mail.gmail.com>
Message-ID: <CAK7LNATMufXP0EA6QUE9hBkZMa6vJO6ZiaYuak2AhOrd2nSVKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 7:38=E2=80=AFPM Jani Nikula <jani.nikula@linux.intel=
.com> wrote:
>
> On Wed, 04 Dec 2024, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>=
 wrote:
> > Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> > literal") the namespace has to be a string. Fix accordingly.
>
> Interesting. Using preprocessor symbols inherently restricted the
> namespace syntax to that of C identifiers.
>
> Is it now okay to use any syntax for the namespaces from now on? Should
> the document have some recommendations for naming namespaces?

I guess the answer is yes except for whitespaces.

The namespaces are recorded in the Module.symvers file,
which is also parsed by external programs like kmod.
Using whitespaces within namespaces may confuse the field separators.
Otherwise, the namespace is a simple string matching as far as I can tell.






--=20
Best Regards
Masahiro Yamada

