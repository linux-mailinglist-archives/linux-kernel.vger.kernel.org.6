Return-Path: <linux-kernel+bounces-548899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE77A54AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E31169C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EBA20B7EB;
	Thu,  6 Mar 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="angw7KhZ"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848A204698
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263962; cv=none; b=IZbNQPutuWWlXAtgaxko6mOolP17pB2eam2bpNsiIfTE/ESkVuz5j1rA22ad+LRYZqH7n8qy4GhoQ7khuoktVRnONc+AAnJQ1+SyhTfg8jFbbH8+CDIcSNxn1ZbynQJblO6wrCMfrMJyt0N4SIWmE8fL9jT07l2hF84QBw82TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263962; c=relaxed/simple;
	bh=cIHmFcN+je4g6ZEkmn2nR9Gls5uOmxfiZ+vKzg2YvJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTlyBDQ4Usy92EvMbvdbuMNbKnX2KaxZasQQzQiqmMtuXSwOV7hChqMZ69LWnJ8VB31FrrJwpCTCzhgBzzOBso+r1IYr85klvX3AXXYRQFYC6Wel8su0J5oII7/l1yPSUelexIpQbDNKePcmRUbwie+e2S2epPJ8FVkoUA7Nxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=angw7KhZ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-472098e6e75so160331cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741263960; x=1741868760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mwY1CncZfvA5yu3fSWfGo19jkVv3bXPIhA3Usfu+tGQ=;
        b=angw7KhZA+BQv/wOEvhBNNW1MpfuYJRQ8n1RBk+/lQlxWcpAPFnmIhpIKDYQxjEJCt
         m6LvnAv3ne/JT/a2a+zPtYzHD0xOMiaY53+EO4FhC/7daIjt0Knvqbbcm2ib5NqE9e4h
         rGE3PYnwRLuBYG7K2PBtnJKj9y0ZHn/prq8Go0j6oV1cYpFv8r70T61xgjiA0vK6P7HP
         owxe/lF7aglk66B0A2EJ6Wb8+X7BUN1/dggSCTzM+ZZG1soBEMSvQNDKi1vkS0rOH004
         Ru5jUz7ft2TomlJoU2C7l5lrOW6crLiS8eHI74C1OYfIuFV335AgSLRUGZXVuoa3L5RV
         uWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263960; x=1741868760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwY1CncZfvA5yu3fSWfGo19jkVv3bXPIhA3Usfu+tGQ=;
        b=xJzLVMEeEUKKLMBZtuYBzyXIgTJBVpQNyA6U2RB8vBobSCRlw/hx50cd1MP/E5GoQG
         +60go/SMErHtclCFA2AYfrqLcx7GBV7glA2VEfBya90L3kCVdUbPJQ9xa3EXlkbdn5/q
         eX6F3mrwCAaaEiptpAyunx3c8l+4F+vFKT1meHo++xz/uts1igHX8dLYpOKapb1lFepz
         EYPnTW2YUh4FtABs2hP9y6l0lOV6PmRKL2pYhkfTlhmMVQHwJM2Ch9ALfxxyHNcfazh6
         Emf1J+ONReCn0POXC0WLlBG1aiSO0YhT5E6cM2dKzB6+qBIORFW047Y8HQ3NodLLM66P
         NYPw==
X-Forwarded-Encrypted: i=1; AJvYcCUbvusNSdEw0Clwew/X82kr6+YxpWjZ95/fPeq8HcyyB3UWgJYLRz44WkAT9dke6tr5VQZruHfmhFSB8Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YySPuBcQGbnX4MbEeGnLL/0BLWPhtYFzrB9R+CTivsWSxzBZvVc
	iItd0q6vzS5NIseOwZ92QGh9aUaJOr2mtzQq+/R/6PDW6YcYDz1soNXH2feeZ59b06oF0cn7ycm
	MpOZjnGC1LpOWRVlIOK+41ce14MRGWfXurAPw
X-Gm-Gg: ASbGncuw7lGUCVHPzYU8FmgAcHq4ewUBFXEKS1LMFh709C220GsnGZLQWsNv0tfu3RZ
	6eSAfpsW48KKt+tJziD9NtGTLwRFg8jvFNzj6BukoNJ2wJbT8SVJFbSCuEykAYuOy9h0edalIto
	XTYmACJxidAPG7HGplxRFH1nFNEU6YtHxynJSDAz7akj2JxaNPxdZG3qqj
X-Google-Smtp-Source: AGHT+IHni+4W1+dtjRM473KGIVmKLfVCgoaUxTl0NChdbDrUzneKPZyDgW+RAtTuH1RuCGLRDb8fjWExtju89vjvr7Q=
X-Received: by 2002:ac8:5809:0:b0:472:478:b124 with SMTP id
 d75a77b69052e-4751b0183acmr3594691cf.4.1741263959960; Thu, 06 Mar 2025
 04:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306002933.1893355-1-rmoar@google.com> <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
In-Reply-To: <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 6 Mar 2025 13:25:47 +0100
X-Gm-Features: AQ5f1Jp-WLFktBvoOoKCDCjh4812bpPlSnhL9ZZNsu-zSBteIHyxLpZPZ9jfly8
Message-ID: <CA+i-1C12kG9t=jqnVaKnvN4xCn58cTeph4QHOTL0+eg98rn52w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 10:00, David Gow <davidgow@google.com> wrote:
>
> On Thu, 6 Mar 2025 at 08:29, Rae Moar <rmoar@google.com> wrote:
> >
> > A bug was identified where the KTAP below caused an infinite loop:
> >
> >  TAP version 13
> >  ok 4 test_case
> >  1..4
> >
> > The infinite loop was caused by the parser not parsing a test plan
> > if following a test result line.
> >
> > Fix bug to correctly parse test plan and add error if test plan is
> > missing.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>

Thanks for taking a look at this Rae! I tried to take a look myself
but I could not really get a grip on the parsing logic in the time I
had.

> Thanks for looking into this: I don't think we want to unconditionally
> error if there's no test plan, though. Pretty much no parameterised
> tests include one -- it's not always possible to know how many tests
> there'll be in advance -- so this triggers all of the time.
>
> Maybe we can only include an error if we find a test plan line after
> an existing result, or something?

Since I reported this bug, I discovered that the example above is in
fact valid TAP:

> The plan [...] must appear once, whether at the beginning or end of the output.

From https://testanything.org/tap-version-13-specification.html

