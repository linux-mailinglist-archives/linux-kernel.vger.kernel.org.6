Return-Path: <linux-kernel+bounces-306338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DD963DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EFF1C21D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDF189F36;
	Thu, 29 Aug 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nuh3tOkf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEB39AD6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917901; cv=none; b=RlYRJITjT7SgcDUnBD+BF6gf33oiJhB0G4NKEuR5xlLXbP+yJFlNl5nPqDs+SSSHNcEmIQFp2CnG4e6RfGovRN0Rc7HZ8xkz0Vst0EzwZ8PKKx9O5WX4lqA77/ylKjNQmUjLMb0wVh7tmfx+CxarmUGVxJ+QxskdDBOhlzx8D5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917901; c=relaxed/simple;
	bh=arR/sffRsobr9Borj4X8VYDf7KRXtoIkqMFf8ghs5Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6JmJURjmtu64YViViN7qICkUZBjySxquW5yEJ54Kc5mNgaFcyxtBlKoJ+qGzXUWWKmLMGPTJdMSW6lQjDOm/uBTV7HpLVBPl8UT/8Ls2uPHMfpHwf8xNhB1dRd53F0OMzzR0igxD6rskLlPesOXZC9iGQlR7vzR96dZBeoYlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nuh3tOkf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533488ffaddso440426e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724917897; x=1725522697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E88LT5D74HyhmMarxCefY4oc65GfE3ptwLbyJI7Amzc=;
        b=nuh3tOkfsSCfXgq3Ojf/0G4fK2WdPToFj5cFVB61CgF2AkF3cFbmOwvZNnztBQtZiY
         j2IZCzNLvKZoHKuV+Ev4Qn3e3h/YlQ3kNmxQdBOtzVyOjvz3BGHgRxjxiqWVQ9XdbXqp
         MQEHRqudPqtnBUGIAgnvtTEcW/qWuWTKk4NJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724917897; x=1725522697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E88LT5D74HyhmMarxCefY4oc65GfE3ptwLbyJI7Amzc=;
        b=KpSQTp9vFJ0/4DQjGvO1CKBOXfM1guwPHnelmwAwx9Ta3FpqpdbJFdgb8y4oHn+Zb0
         UT4pvu5CVTo+UbILk2bLHVOP2bOpMt69iadI2wbf/ToaGoIXS8uGoBqfJVIxscBrphV5
         OvfK7SRQTW8Yirdie133bxdOKO/QVTPPf+/og7lJxiONI7EARyARvJqs9Wh6dn1zFbKi
         7lEJaf9SsB1CUY0+s1eEH1cf/AndfnwXhie+Nas02jK9pKSlaBNP+q9DOZeaAf9XUdTE
         Xh/GUVVdYMLlnWmHOoPAAgDY7W6WbGnik2xTGbAFbmWEhIIqT2Pj43RZCSGhUqoEfw2H
         9E5A==
X-Forwarded-Encrypted: i=1; AJvYcCXzacsyJaaM7wBYghNuD1AW44YC/MZPqpRTmmaI8riOzzoKqmP15/Nfr0D94nIEjWROJjOTiSgPcMBPqWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbf7pXKjh68O7WV/mPQwfv3PbzVA0eip9/wyUCqsDry1g8Uc3L
	HuVIwBJ4VUPwiCf8B+Oipo3KhKql7m6EAkOpZfudZ1QP0krpiyPBCoGwgZMsUQl2f60XAiifCFh
	477nwWnsTj4C9/1bL9B6J7TmybEhfKoa+AKPnkg==
X-Google-Smtp-Source: AGHT+IEWGAYWw/fSwcJOQ+/o+9pIqQrvIPE/w5ugEv+xbpFYiBYNMLRLtLp/5DzAZKrFPIlkHWk6IKYg42J6jWYWDkc=
X-Received: by 2002:a05:6512:10c4:b0:52c:d5b3:1a6a with SMTP id
 2adb3069b0e04-5353e57fc94mr1225703e87.28.1724917896827; Thu, 29 Aug 2024
 00:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
 <ca86fc29-b0fe-4e23-94b3-76015a95b64f@fastmail.fm> <8fd07d19-b7eb-4ae6-becc-08e6e1502fc8@linux.alibaba.com>
In-Reply-To: <8fd07d19-b7eb-4ae6-becc-08e6e1502fc8@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 09:51:25 +0200
Message-ID: <CAJfpegsgCJEv=XxuHgo+Qn-3y8Rc_Bsmt2YKTHn4XaBqvgshew@mail.gmail.com>
Subject: Re: [PATCH] fuse: make foffset alignment opt-in for optimum backend performance
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 14:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> I'm okay with resuing max_pages as the alignment constraint.  They are
> the same in our internal scenarios.  But I'm not sure if it is the case
> in other scenarios.

max_pages < alignment makes little sense.

max_pages = n * alignment could make sense, i.e. allow writes that are
whole multiples of the alignment.

I'm not against adding a separate alignment, but it could be just
uint8_t to take up less space in init_out.   We could have done that
with max_stack_depth too.   Oh well...

Thanks,
Miklos

