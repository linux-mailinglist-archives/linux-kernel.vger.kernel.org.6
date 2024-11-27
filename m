Return-Path: <linux-kernel+bounces-424055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A429DB022
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91808281917
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC391990D6;
	Wed, 27 Nov 2024 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNuMQY9z"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1119538D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751831; cv=none; b=HZrxZgLDcpC1iXYqnjJchE/RU6kM1Q8bmCzpEnKsQicOiE2TfhPxYETXbS+mtxxT6/GjL2dNGed1GlSHN16CXVhqEiaWaSyt0gib/S/U3q339q6s6Y7+kKhNgyleULDPXS0E75Zvf4quhw80kEeMBlDBjDiH5G1A7kHybkyWa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751831; c=relaxed/simple;
	bh=gThBsz3+hRwi0ezlPl0OHla0tdLsXvJYTiWleIRrU+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4490kwH8stDTeWzNL3REApUa92L4LpLjtUtqYB+Og1+NvMTdwU1oM2ZMNDLVGLhJsXmFeZSMJl6OFL7tW5MKnKtsmES9bRrP+xhsDk0p6HJFVBBY9Hc76Ch0IJy7GTT37UMG83+nQQuB3tBaPGmTsQnNcNLz9WGQKEJhG4fq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QNuMQY9z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so42946266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732751827; x=1733356627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPlRZAjURNuIqI+1cp/M1BdMXf3esRQ0x/UNttbDRTI=;
        b=QNuMQY9zUDd/8X6HNJBPHD1/doD1M45u6tAU1rttGKLO7fZtL5qTuurayat5Ar8gdx
         cpwYERxpewxyqX9enTlWzBZmKnIYT+Xggvyhd5YLOLjYwQ7YGUDN3tgwRTM9EkpvQxRE
         N/3X6iytt/pYhxq2xOIicVA4GS75FyoGgBvd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732751827; x=1733356627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPlRZAjURNuIqI+1cp/M1BdMXf3esRQ0x/UNttbDRTI=;
        b=au0gP9lzTc5O/r60jYSCXvEKFiNOaqWsW7CGrC2n8/phOFZjkWkDZSo7aXqTFlYwc+
         nSith8LJHAHEXCVq4v67Lou6xXw86otMwushfXriI5KNmS+IkQ9ldhsF9ejqCzapVUOf
         F9O81h6xqfgZPmLleT8OGPyM7A9Kvk72SbUu/TBj57tDzMUVljYBsnwaVD35PPX4xRRv
         CrzD+oFGYKRuXT6+l6TNI/z9xlvrKEhU2Kc21/iPLme4UDt/jqnEI8FKIPal8BRn3ny0
         qTSq7HKVIfohmgXeGIYBP/meq1w6nHh7dhmWmw2SI1cAWlkXkbHo2+dJotO1KhW3XMeH
         STiw==
X-Forwarded-Encrypted: i=1; AJvYcCURVCzT5ZIfnHMyPc/GlEXz4kRul0aQltDcCGQM24W4+Kd8D91M6h7atsWsZLjLMq/TQAwn0Wl4tVFbugQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxArLR0fuN31sQGP93g9MC2eA3LBoZqKZseBbVUBbFid9eM86m
	aARwBzuz+yMyvUbg7OzTM+cyzfLY17iiYCQQmnrS9UuYC0l8gGImj4WfQ6PI1M7OnnLA4PgN1UR
	0QMQ=
X-Gm-Gg: ASbGncvOxa9QlgI+uBGr1Gmhj3F3e66qcur/GTvIBfqxP/wTf7Tcr1co0+DvxCzNCgD
	kyXJHguAms11kX4A+MgMW4f2rc5NPxi/1KnQWjgMnKYe+6DrlgCdweN0rVu9NrezjJsMPJpxwai
	ur2EoLUGtDDgQa/ptY2extbexfgDr50t8NPik4Ip8CAt74zg8glmlRrMsx97fik1xUbsKWN6TxV
	PQ+9C4d9wqszc+cHINPzLZ7wpFTogD4ndRsIVc9RX9bLStkokiujgT7HGPk4WltPzpPARLuP7KB
	VpyqXzv8How8IoTSHApHtJHE
X-Google-Smtp-Source: AGHT+IEgdm0Ew2q2KAeSg8fe9igKzeze15G6dYJokeS3mp6dMc7LHr33ow/K2ZlYlR+wGmWuzkggeg==
X-Received: by 2002:a17:907:7802:b0:a9e:441c:f729 with SMTP id a640c23a62f3a-aa580b2e09dmr532305466b.0.1732751827379;
        Wed, 27 Nov 2024 15:57:07 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59994064fsm5087766b.174.2024.11.27.15.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:57:05 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso39587466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:57:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg1StTi029hh9esNJoL4aI6rGiSMEAsgYcOxYRExRBsxsLQSoFnRP4tr7VWDkJPvtial/YAxSvnY0WlAw=@vger.kernel.org
X-Received: by 2002:a17:907:7754:b0:aa5:1da6:d4f2 with SMTP id
 a640c23a62f3a-aa580f22baamr487890266b.22.1732751824877; Wed, 27 Nov 2024
 15:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0ZxiLw9hauUynTS@bombadil.infradead.org> <CAHk-=wjCkJsdLageTx6C4n--aYFoO6gSRe0Rwcbk1jQdOdiPfg@mail.gmail.com>
 <Z0eeuCyUGcKgsc5h@bombadil.infradead.org> <Z0eqiayuv1w4a_dc@bombadil.infradead.org>
In-Reply-To: <Z0eqiayuv1w4a_dc@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 15:56:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+imfGvW73XoYn60bAMzRtPfXFqwFTUqBoEq4=u5_oUg@mail.gmail.com>
Message-ID: <CAHk-=wj+imfGvW73XoYn60bAMzRtPfXFqwFTUqBoEq4=u5_oUg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, masahiroy@kernel.org, mmaurer@google.com, 
	arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 15:26, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 27, 2024 at 02:35:36PM -0800, Luis Chamberlain wrote:
> > Sorry about that, I'm on it.
>
> OK here is a fix, goes double build tested and then run time tested.

No, you misunderstand.

I don't mind the tests being built. That's *good*.

I mind them being built *twice*. That means that there's some
seriously broken lack of dependency logic.

            Linus

