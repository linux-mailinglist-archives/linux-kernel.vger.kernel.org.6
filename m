Return-Path: <linux-kernel+bounces-304842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D79625A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03EA2847B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C9F173332;
	Wed, 28 Aug 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl56L+oC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613811714AE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843559; cv=none; b=sIexBpZMz+hm3ER1eiQIJlD8es4uc5BEZK5g+yiG4kA5bfDnfX+m6ihNQz6PXYR6W78azlKpfM71e69+bW6PR3HHwPVGiwzG9DkohIRev3emk2eqtKr50vC/wvBDEL6LGP0JjrpxzR7DihW5EL0pspuMorHgQ3XYnUZqjXkP/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843559; c=relaxed/simple;
	bh=LgiVOI5qVTCCS5dtb+bNzyL02Ch2FflYdV2TklbIYNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RE4nr7KqV5XNYbX8DKWFeh+hL9zZvKcakiYZ9bPr9NKqjtAD4sHFwZ5ZGTUaSzX9qGFLwjo3+IzVc+blKClK4AkkeXHy9JtlIat441T4i96+SOLjAjorfYjA3zGUDv7UVD/mx0D0WRAJ9/3oM+UAAaASpzL0zl+DcFjw1PU1PCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl56L+oC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280772333eso9392565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843556; x=1725448356; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txhZlsAYGeDtnXufBnGmOTBXhEQ7zmtcc1B3AKZQ+/A=;
        b=Nl56L+oCEsvnR1zuk+CfauzqgcWpLiFVVijTIHhYD7+D01ivyYekwJB+CZptdtu1u3
         lTF/dqFBRFk5gRTXYTJFIm72fgHPmls4vnQiBSLLzK7xLZcng+MwbdPgwZgn7LBQsy5L
         BpVcHhfepbAU8FY36slrXUWF1iMyY7Ato2ZFev2BDTd8FyC1BwtzVuNc08tMnIbc+gjI
         rbgBnZaeslxuCkLhGIXNQ2msRNv8tQalvaJgqH5jpAokFwTf94HkblaYMUMg4/4KhbGX
         NIRfyj9DHay2W4z9D+qfvzzw9kke/Ix3KxuV0AFIS+hIt/5cgne1QvQrvlmWSw9sOJu/
         OpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843556; x=1725448356;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txhZlsAYGeDtnXufBnGmOTBXhEQ7zmtcc1B3AKZQ+/A=;
        b=ZQmEg4089pIS/QQZX8nJ9KIqQ+R435Ta90kmeAEaU4HmfgE36YovDmq810ifTBtPwF
         oiDzAwD1YPVBj1JgCN5jodKpveLvvW9AhknP0hV8F2Q213pAZuqHQ7ywNoEf7AyXx91M
         3je8f56e1oL5RhYxt+SSZEP9gU1iKD2JGnI7FpIWlmQihPzURUj0nh+5/tsCOQYVodpv
         zUa01xUATvRfVpbiKmN4V9aD7UMsrtWbY5wf8tnPX9DUqGWrT5yOrC+EQOme3krIxOcS
         AaB2oWw0MYbFFsLTD8TJt8rXTSingDBS6mBrLTCaaxsjrxo0HH+B5xIg4S0dW5MBoACN
         0SbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGYVyW8JmJCyjhT7fi7IpraszbFmaAepMr84UoMfd1kAl172/e4ldEQPOfU+dcZvkWBtdCw/pEYeQ+xDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+4MgB8DLvofm0Gfdcv0oikOk7e+egWMoXzZBZF2KzZHa1e+y
	+XptHmUZiXpdTdKYy8Dlx1TycluLDGhENxxFzKTVi/mDjCDuk2D4fBn0oxffn8pVJrTzo0+9+a3
	C3tc6jVQMzU4dXw+EDQ7B07jUZwc=
X-Google-Smtp-Source: AGHT+IGRaZFqTTyibBrsLhis7BkPmCRbmiEquyDewYJf17JrE+fGoqQEaxCWmLPItFAtApdFvwY0Fek/3YWKmKjS5bs=
X-Received: by 2002:a05:600c:5118:b0:425:6dfa:c005 with SMTP id
 5b1f17b1804b1-42acc8dca6dmr71467155e9.2.1724843555175; Wed, 28 Aug 2024
 04:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEJ9NQdJwwpYmGmqm9BESViBDH9P=QQJVZfnO12BTESEKYRFjg@mail.gmail.com>
 <20240807190217.f4ex7xlzb4wpxxnl@desk> <CAEJ9NQcYU6dRZJM818Ae3f-H86BKo=iaya7jbt3BH+G1O1gsQQ@mail.gmail.com>
In-Reply-To: <CAEJ9NQcYU6dRZJM818Ae3f-H86BKo=iaya7jbt3BH+G1O1gsQQ@mail.gmail.com>
From: "Shanavas.K.S" <shanavasks@gmail.com>
Date: Wed, 28 Aug 2024 16:42:23 +0530
Message-ID: <CAEJ9NQd+SEEesyo54Em8cj_dRnYxkzC5fbRyU8pp2FeCiKJjcQ@mail.gmail.com>
Subject: Re: intel CPU vulnerability NO_SSB whitelist for AIRMONT
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thanks for the response.  Please create the patch from your side

Regards
Shanavas
> On Thu, Aug 8, 2024 at 12:32=E2=80=AFAM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Wed, Aug 07, 2024 at 12:57:47PM +0530, Shanavas.K.S wrote:
> > > Hi Pawan Gupta
> > > Thanks for the comment. I have checked  IA32_ARCH_CAPABILITIES
> > > register but it is resulting in "unchecked MSR access error: RDMSR
> > > from 0x10a at rIP: 0xffffffff8286cc26". I am assuming the reason is
> > > the  MSR register is not available in our processor.
> >
> > Thats what it looks like.
> >
> > > Does it mean that NO_SSB should be added to the whitelist for
> > > INTEL_ATOM_AIRMONT_NP and INTEL_ATOM_AIRMONT_MID if these processors =
are
> > > not susceptible to cache speculation vulnerability?
> >
> > Correct, NO_SSB should be added to the whitelist for AIRMONT variants. =
Let
> > me know if you are planning to submit a patch for this. Otherwise, I wi=
ll.

