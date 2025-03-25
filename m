Return-Path: <linux-kernel+bounces-576095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0384A70AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A1918896EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632B265CC6;
	Tue, 25 Mar 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAXJ7klg"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD7197A68
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932964; cv=none; b=ZOk5e+9R8ErJ+IN8gE4JcLMrrVCQMP+0SqgajNfwbRvz8CnVggCUBk/UpAkrzlSag+3W4Ug83Mh4IpCemh1j4zIeqCAO5i7tsP4/W1Z05XYwzyeoXNIEBYbCqwSu7w9xZ91STgg1IUvb+aQR5V7DUm7k4fQFR/vBMAg2bv5uJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932964; c=relaxed/simple;
	bh=83oe9Bd5u2OA+GvtGvNLfdpCijNddL/mYUFyTGyXN80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3Uueiv8IyK+JuDZth0yGmC4QOpUuAnmWGAIou9cpM7eiHH+/3eLrj+npPLao5AnWwV9yh/02J53lVz8n2GcgBQCseNxVeR2HjVkr8AJYjEbjWNlNxlbobsCoZsIwtPgC7C0JhRNGwOJ3zAkx1FzchpIPv6J5/fLQiyh3MFITHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAXJ7klg; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6febf391132so53426597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742932962; x=1743537762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I2faTc0N8dUSkBrVYW4gMbPX1pdfOqcvzvNOpszxEK8=;
        b=SAXJ7klgCTLyfBTYnWTPKPHvmB15VQ6+Z3AW1IvsQc8kL00LAHJJqRdUkZfPzZUGeH
         DjHhMoWm6LDR/gOVyqgH/0tHL1XbxOUC1dpNrM0dgKCt7BemIWEwJRFgaBXDb/ieHKPf
         3+lQwC9phG8qJZvmkghP7IsZNx2WZPqvG1mBaJcCIM6gfddfJeF67pSRsrHjAW3MbeUM
         dieltXA99IBul5yzqz/fDv3uVpDiXhDAP/jlsGZCbCp8weetH63WwKR75WEEI3YI4y08
         Y6qNS5s5RXgt4iAGhtbDvdLovvbvNYuJ3bt0D23nPiNiz0yI9TzxBTcjTRmB5oRd6w0l
         4eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742932962; x=1743537762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2faTc0N8dUSkBrVYW4gMbPX1pdfOqcvzvNOpszxEK8=;
        b=BErfpYgwTfP+TOxYgzsV/ExEb/b0Qpxhkph4dYr9AZJlStt+smZ+caDtDBrA2m3eEQ
         x2nScVpyAxUw5oJ0JrcXn7dOZrZkQrTKC4WY+xv4uiMC25+i6xP8AwSgmMkbTYvijYO2
         paVvj4YCaHDndt+bWmAtSo6/x992fw+ruwhKqQVXyp9MLgC2Nal4I2gyUOxN8+lD+cCk
         Ckm4/BURKm0Zrcyi1BAPE0In9iZGQ+aj7OZEcUdnx9M1aYx7G7uOseP/lxt5a2baT9RQ
         CkuYKPpTzJRiojMpQ1mLY4RkVpIkNtoZoc/jinig6qbJxz2RIsPpfWr5xK0jVq0P3fex
         mlag==
X-Gm-Message-State: AOJu0YzYSfVr6cFOEiQVwMgQ92qJo3DZKlJ28fNam8qHcIE5bsfd/ksk
	akjBkPLgxvaN+Ci1pkPQmueGPw7Ygmoy6dUAVFhgksjl3t7q3e72O1dDCvvROaFaqptNkvr0b7a
	2QvFG9NAk09qTiWOqOCrm0JqcLrI=
X-Gm-Gg: ASbGncu92+mJAgjW7iFAd87CUO8ekSWhCMF3cst14+1oPD9Pgl/WSGTQ5IKX1mpOy4t
	xyHA7vj4Gvp5fI4kyH/fBzA8kQ+N+gfzXrJ/OOTGjX2mLJ+Us/B5m7183RKKxG5ddy4hnR4IFg1
	Ti99uPAUIzP6mQ8bvExKobJbGE
X-Google-Smtp-Source: AGHT+IH9GDIqWqxErm4aQOy3gdrX0Y7vT6Ol7W40H3FZP4x2c5Yyjh+qcjaKP0Q4YvCkkEHJWvv2y2zX+XaXamc7vb4=
X-Received: by 2002:a05:690c:640e:b0:6ff:1fac:c4f7 with SMTP id
 00721157ae682-700babfd2c9mr222461787b3.7.1742932961820; Tue, 25 Mar 2025
 13:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-31-jim.cromie@gmail.com>
 <0828cfdb-abf3-42c5-8500-70f36affd0a8@bootlin.com>
In-Reply-To: <0828cfdb-abf3-42c5-8500-70f36affd0a8@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 14:02:15 -0600
X-Gm-Features: AQ5f1JqaIKZ0UzULldrvJ00SprmeHiO70GjKwzUCD9IdsSYmGwkcVcHdtLPOdIg
Message-ID: <CAJfuBxxqQ3g1urkbdAhbBi=1rk7bEqo5R7xws14xY98s0t9gUg@mail.gmail.com>
Subject: Re: [PATCH v2 30/59] dyndbg: drop "protection" of class'd pr_debugs
 from legacy queries
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

> > -     int valid_class;
> > +     int slctd_class;
>
> Nitpick: can you use full words? slctd is difficult to read.
>

yes. done. thx.

