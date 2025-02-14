Return-Path: <linux-kernel+bounces-515005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157DA35E86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC6F1897176
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E882641C6;
	Fri, 14 Feb 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fSaxiOlE"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FA523A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538520; cv=none; b=jTmf9BEYzm3pftIiyHPVqRjf07HjTawn3M66RrEDhDsXWqw+yjvekwHgpjm/T388ZCLNlb4KAhV52izCr46oVUkhdSpNIEYfdnzKl/X3tLp8jhJGOfkyByEdykSlcE4GcZ2hI2gIVLkd3TjEQMx8L4jcfSb4WpVA25dRMrCyYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538520; c=relaxed/simple;
	bh=neEm4+Cx/iEQVvb4iKsSOqlmD79lxM637n3ua8WM8qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reu9FJPB1VzdBCSnujPE993WAI9c4q5oUTLS0D6QHzqTLTMqiINPkQDVBgzpW6CraLC+08F9THY7r041T9ZxGObwzCMsLzB2fDljMsLw6PQCZUJBWQURx4UIwGCX9YSVs+ITKNS5+btmdcFHvdMNGrzlogxp9ZOQQNqJ3AB0fM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fSaxiOlE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d583d2afso562623666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739538516; x=1740143316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FblFcMwedzNnfAxN1Z4KRU7BW8Pt4N7aNbycDWrv6Kc=;
        b=fSaxiOlEK7l/SvIlK0sQYJJfqn6g8Q9qkE9RA78PlgGL5rutY91dsdgq3RwNnksUcq
         PcxRjWWkaMJCbYOpMA/RsDkBIH6JPLmSI54PMRJBBhorvyu+6sOhRunv+3rphpVB73lA
         bdZVcxdB4bpfftnBtF5qc8L1D7oHuQ3vy7S757+rFbbX7+bBzJCTSk5EyeRm5Oh3i/iV
         lb7ag4YmsBBFOIsosKY1MfXswoP6m61AMTyvIOhugrLYWuKjjn3WFj3HquMm7wqyrY+T
         jpXgZzJ56RDdzZ+jSXTdMk+LoIjSXu3hSpFwdWwvAFP0kpAn9h+Dui3afB7nMRnhkW1o
         rgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538516; x=1740143316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FblFcMwedzNnfAxN1Z4KRU7BW8Pt4N7aNbycDWrv6Kc=;
        b=sJLUphO1UyrlU5YSY9tP6O8Ss3diXbD+G0W5unkjplRp0gsd5Yq6OTHxjhlpr4OXSY
         P3ZQ0hiE+7iPKm9r5RwbypiJpSD6ymFjDqNUX+bYruJFS76cwo+P6pDVPYwAS89hpNC2
         n8fBFVLYJwp8/mNYl5kDqycWxUzRp+euYoK3+uccto9g17VMTrW8WJWKrtpt8pZWtoaR
         6sHuZ+CnY1ygupXt9RFdmTiS/FTM6c3BGCVqIj+CesjM+88i3pbmb6tOeakyDNkRt82v
         XeOA13r+RUwllbxujEwPurCyvvozSV9hbHOv/N93N3ncq5rWqok4wyQPVPbkPJzG716p
         WOuw==
X-Forwarded-Encrypted: i=1; AJvYcCUI0qenDBzDYnMRMpiC9LFv+mvyOZj+RcndbC0DDoEKIu7QJZEPAJ/vGr9yN1Nm1U/1w3f5ag+FeL4ys1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2s2XCjN4P7znIcF011Ijh4HzAyI8cNq/LiNSmvnKK3Bf3i+A
	4D+mznH+TA8+CfeNX8SybCdSOoWAinkgxelueF76t/O3BcwmjCbPnf7BDM8C3wd8hxl+JYM03PB
	VcvXW1eYdNFh23hl1Jz4Qp3qxOLUHn3rQKsPT7apySxsCKKcj
X-Gm-Gg: ASbGncs/kYkC3Iv3+atibp/ng8rT6VhYILOD7dmkKe4ddvubqKBqCAfmDgCKGk3KjYy
	gXhEtiaCVcku7MiEFW4rHd4EDOdDeUdAZmVxsTXZCAmh+PqkfOD/el6OtA9sO4DIi9Tam7Vd5pa
	jLkcchxBEwuVAkfV5PLaCXpdv/BA==
X-Google-Smtp-Source: AGHT+IF50ioArXYzWdb9AwMM5Jd2Q6Gaky4E7wPQIfV+mgA5jj7trK1nfZmCALNES+0mGT+0rIc/VOt17oANdRVwXjc=
X-Received: by 2002:a17:907:2dac:b0:ab7:462d:77a5 with SMTP id
 a640c23a62f3a-aba50fa00c1mr561174666b.7.1739538516107; Fri, 14 Feb 2025
 05:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211093432.3524035-1-max.kellermann@ionos.com> <3978535.1739538228@warthog.procyon.org.uk>
In-Reply-To: <3978535.1739538228@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Feb 2025 14:08:24 +0100
X-Gm-Features: AWEUYZnphr9tXHnNU_D4Lm2cTV5HRLCiurerIEsfzwR7a2ytXNxgP0imZ2tMeI0
Message-ID: <CAKPOu+8fGrCgzL6q0SA+WKesMTDEMWkOgTDb1AA_=GN4_k3abg@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
To: David Howells <dhowells@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:03=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Max Kellermann <max.kellermann@ionos.com> wrote:
>
> >               prev =3D list_prev_entry(subreq, rreq_link);
> > ...
> > +             if (subreq->start =3D=3D prev->start + prev->len) {
> > +                     prev =3D list_prev_entry(subreq, rreq_link);
>
> Actually, that doubles the setting of prev redundantly.  It shouldn't hur=
t,
> but we might want to remove the inner one.

Oh right, that line shouldn't exist twice. (Previously, it was set too
late, after the variable had already been dereferenced.) I'll send v2
with only one copy.

