Return-Path: <linux-kernel+bounces-433248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5999E5590
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA8B2818CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1E7218AA2;
	Thu,  5 Dec 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="F+hnxEN/"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16221885B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401975; cv=none; b=FjDLwhqxSTJd8Qtsmyjc5NZCP8QZxDxAB5lAGw/DUM+W4Tn4dx70xSicyOQ+ZPP/hQonetCSKvmgI9R3Tbx3OVc+rokJIo2W2yBe2BAS5vKAMuo+YMvvbBveRw75qDcOQ5Uz/cFSb5im8LKzTMKMrxlx07kwAMRXHuMPvYyy82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401975; c=relaxed/simple;
	bh=SICq+z4FvKUb2+AsoJsYpc3oHluBTbU20hPC//BJVrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N08RoYztPCjH2enMfH8VgZ6YdkJThL9n4VrVxfQeSzFfmh16ECMxALaE+ALwl5AJfqx/AUr0vDpmjVfBDKVt4VGMk1cKbUhDuzs5zzQjRvHSwOyLz0Ca0YXfZLiARS3rprrI8BbDnzEls0s/HEJ6Kd+RuuROvYCj43DCLVJNgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=F+hnxEN/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso781893f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733401972; x=1734006772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SICq+z4FvKUb2+AsoJsYpc3oHluBTbU20hPC//BJVrw=;
        b=F+hnxEN/qLkKroIT8JQLr4+k/g9FNGJajepfIrnBgBde8zZ5vPEICXk7ZTG9qDMgXv
         sVDHvQVFqT3QBZICxLjYve/juv3p3ESLpexLX82ocBxV6C/fP3DtzevaFnXy6dtjM0dH
         a842tlWPsuaRaVZ/RoeMKI1rhnr6pmhOmRbISknZSkxBkkurvA8qPnPiTQKcFtGg8Wae
         adOcqh2CJRpHLnasye4txY2qdrFXtDx03ubf5hdOo5GBgJSuhf+ujn/li/aWxrGY6i8Z
         X53D8/1TWeO/C+BMveyd2WuJ1irVHgnyHVRsf9Qt1nulWiRV2uLo9WUpOIAXPt3XMWdN
         1+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401972; x=1734006772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SICq+z4FvKUb2+AsoJsYpc3oHluBTbU20hPC//BJVrw=;
        b=E0oNhAIOY0ld5eeqyLi0odid4qHhGLnuTQGPwiZenfSb4BsHgAXWRfEO0AluMqdF8d
         lpoU4fBXZTyWh/m++cTZcqm4LeYhb5YtO8Ry4V8djjrtzZySINbotu4a0wp8Vh2aAQPx
         xd/RRCp+C/cWsK5DqML7Usss97ZvaCP1TrGtqivis4jFy0tPyxg7P854/PTc/mDYDJxE
         IOwyqpOVAb3GpYWUoBHcaNAogSc+61vtFGKk4MW+hpcM18Hw9Mpdfw//B34c55ThX3EN
         NzMjtZ4KVNC+wySgDtDvABDrSXDOCRXT0BI1IFcUfpQ1nDqAuWPDX6XWEtsjq0G5cx7L
         bqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUcOne6fb+d04Ver9yGd8BRjBxigZp48iSvfAjjrcwbWH/I8y0bKAYpAbUvWxZjR0CSzvacRxnrYNARVJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZN9L1x1DhUYgvT0iS+ERJFFPrpduYdyHJu/pzJhoDCXjwQg4
	t8gLAoCjoUP2PRRbevopZyW5xlo6SrVizXy1vJnPIKs8gs0pIklqyJ13K3vU41ubGr2y7qqtnl9
	lpUZKl6cUK+2k2XGSPIszVxH2kTN8vu8G0OgQ1uz/ytjaaQZSwID1mQ==
X-Gm-Gg: ASbGncuPdJLUqBm+c0lMKRhRnrxKx8XxjuVib1fpyxMWzVFJsrWJoj51eufXATBU9Pj
	+PcdVcZH8cni5bgND7fzaP5CiOp56RBiMhXyWQI9727oKBwjIruWTTiWbDsdx
X-Google-Smtp-Source: AGHT+IGBUMPYkDHhpZtgXkNGZC5MuZ6zkQdIJVzzw0g4SwoSv7vgu3hK9RNRvwJ1OBmrpl6dqNbtn9oqap/F09Uuwpo=
X-Received: by 2002:a05:6000:1acd:b0:385:fb40:e549 with SMTP id
 ffacd0b85a97d-385fd43c259mr8451126f8f.55.1733401971756; Thu, 05 Dec 2024
 04:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com>
 <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
 <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
 <CAKPOu+98G8YSBP8Nsj9WG3f5+HhVFE4Z5bTcgKrtTjrEwYtWRw@mail.gmail.com> <CAO8a2Sio-30s=x-By8QuxA7xoMQekPVrQbGHZ92qgresCDM+HA@mail.gmail.com>
In-Reply-To: <CAO8a2Sio-30s=x-By8QuxA7xoMQekPVrQbGHZ92qgresCDM+HA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 13:32:40 +0100
Message-ID: <CAKPOu+__w0yphmYyCX32_RkSqt1dMB-w0iz45q+B+Z6Ve-p0Qw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:17=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
>
> The full fix is now in the testing branch.

Alex, yet again, you did not reply to any of my questions! This is tiring.

The full fix may be a "full" fix for something else, and just happens
to mix in several other unrelated things, e.g. a fix for the memory
leak bug I found. That is what I call "bad".

My patch is not a "partial" fix. It is a full fix for the memory leak
bug. It just doesn't fix anything else, but that's how it's supposed
to be (and certainly not "bad"): a tiny patch that can be reviewed
easily that addresses just one issue. That's the opposite of
"complications".

> Max, please follow the mailing list, I posted the patch last week on
> the initial thread regarding this issue. Please, comment on the
> correct thread, having two threads regarding the same issue introduces
> unnecessary confusion.

But... THIS is the initial thread regarding this issue (=3D memory leak).
It is you who creates unnecessary confusion: with your emails and with
your code.

