Return-Path: <linux-kernel+bounces-335588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3497E7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829AE281BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08437194090;
	Mon, 23 Sep 2024 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEvM3ldn"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A813032A;
	Mon, 23 Sep 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081152; cv=none; b=MbPrDXGCs8EJeR4aX/KXz0ik/Vl7sqqbO8QktKFywNPMGSZfh2txlSTLIA9PECI24CqRkEwFPn9r1i2ggLRYxi0+NbzJZ+2W4x4yAK7WliVWv3iU1uQ3+za4K4Aqc6JB49BeLlguCxYE8guqPhgYWq2bAn/v2aKufjEtI1nMj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081152; c=relaxed/simple;
	bh=dqYEiBbupjRg1zIR1DoGNbbHYOqQUOZ7smtF8tjTIjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpKNMPJp1y1wDZx6H0oovux7REn5aWIKlAvvEOcFLI5Dp4nrZ5cV63src6LCWSzaK73YwnE8GIXM/f69RNYNYHWjNlgz+TB8MFL/id7CGTf0laAtlyjgltZqc1ri5sluM3ZVciwdtsuS7tvg88Bz0yCo3f3T6yQARJr74s+gwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEvM3ldn; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-846b934981aso804496241.3;
        Mon, 23 Sep 2024 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727081150; x=1727685950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dqYEiBbupjRg1zIR1DoGNbbHYOqQUOZ7smtF8tjTIjE=;
        b=gEvM3ldnhZvWkbK5LwH23aqVNUrkX00lYK9TvyO30MbGrvsxBaOKaulPoMBxlT2QOh
         NaBGyXNsQHQpD3J1kdDTvE8Rp9aicpMExDBOyxbD+e8/z6Vou+M9X2bTBPLbFS8p3EUW
         NSGFCyNe+ZYikyX8VlIbpm+Wy6ZTCuNIf3wHaGipGL6qa9aEdOzXdTCdDe1o3ThI5dW+
         ebFd4gVL4Hx8/5l+1UncAg20V8umFSUX4COQe1mDYY9pUI542rkz1h3h20FVW0b00YG1
         +V3lzc9KDbfwjDjMFMJ3xB+BXWtYIv2BMOql+rwVGDneGVteRXR4xpEpuYkEeEKRfNNA
         h9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727081150; x=1727685950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqYEiBbupjRg1zIR1DoGNbbHYOqQUOZ7smtF8tjTIjE=;
        b=ReYHxkhIf9niOx8GU6euoYwtFPjxaj9wW0aTzVpKHT2c4RWtRNZ4rcpvB0INFkX2eF
         MQgBOs9Qjv5D2iZmgEvChuk0T3xb4FVCaByttCeOy/NueW7A9YASLINq5hhugDdBpoFP
         Y4DZAnk2WJGAxdvtfrtSmQA9FBjbF+jk35S/1aMCYH11ByMhpQsu9K8hNdmKhlCjT1la
         hOs+wbl2JCf+tyc0hQaIs1xlETpvRXUWgBd9bugd7Hqw8qVVFS/L93sR0c1iiTbt899d
         swrMjPrpGulr9sSaL3MwSxeng9W/oQkM7uw0gg1fY3chsQ4IoBGy6Dx+5FfWIW5Kth+l
         f42Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgiYpa6xJzCNRL8gKRhF5NUCsO2XnT8NFTofOMoE2sQOt9WEb/x3y3adLxWoZPeoF/WS8Cd1X4A69BYkA=@vger.kernel.org, AJvYcCXrOm9iO6k14D16QRKgR+P3gSuIp4W4L6ZTDTzL9pq6lLUkyiVYZJYWEHWIE48IFO9bQ/ulmg1pWfNY@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4VXO2wjYZUosLMQpICEKuqsvezA5+YSu49VrdvaKqXiOvUqh
	4EelrSql9lEq7FpfhPYwpREevUBmF45alvD+cwgNMDcJhn+xe/Z31nzE/pjNYRUkeg+Z01HDiDT
	jqKC/E7Ut4mW/A9yU1aL6mYGGSik=
X-Google-Smtp-Source: AGHT+IEzbx43L1g7xNzICxB6bl0i3dkmy4SfSzShQk/2kMz8ApnMlXSxFMXtyZkY5Hp9AjqMiQ32fjxz3oAf6LqSXEg=
X-Received: by 2002:a05:6122:2225:b0:4ef:678e:8a90 with SMTP id
 71dfb90a1353d-503e041b6b1mr6407274e0c.3.1727081149835; Mon, 23 Sep 2024
 01:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922105212.28099-1-kdipendra88@gmail.com> <ZvEoVC_j6jdBhvim@kuha.fi.intel.com>
In-Reply-To: <ZvEoVC_j6jdBhvim@kuha.fi.intel.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 14:30:38 +0545
Message-ID: <CAEKBCKOHEynh1CLDyY8uibUXt5XhU6yGDRKAswfeQhVxGVAdEg@mail.gmail.com>
Subject: Re: [PATCH] Fix dereferencing freed memory 'fw'
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

On Mon, 23 Sept 2024 at 14:20, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Sun, Sep 22, 2024 at 10:52:11AM +0000, Dipendra Khadka wrote:
> > smatch reported dereferencing freed memory as below:
> > '''
> > drivers/usb/typec/tipd/core.c:1196 tps6598x_apply_patch() error: dereferencing freed memory 'fw'
> > '''
>
> This is only my opinion, but I don't like those '''single triple
> quotes''' in commit messages - they are just confusing. You don't need
> to use any kind of quotation marks in cases like this IMO.
>

Thanks for the feedback. I will send v2.

> thanks,
>
> --
> heikki

Best Regards,
Dipendra Khadka

