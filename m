Return-Path: <linux-kernel+bounces-235336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86091D414
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F582812A0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85B41C73;
	Sun, 30 Jun 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgU/3Cq1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639444644C
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781315; cv=none; b=tboCLPwZkI7MobfjB02RKdoO7xNdGUAFC9F1nDb9byq3DM49KjbLKpIeS+PN47SzG2lNGfPNpkVa0rewBUYxQ7LB4aSUDDz/GazQPXT6135e7OvECq9mHjGvJ02xoVxMNjgIw4WYo9cLOFuATzQKNopFC79Kjj8XP1RIqwgz+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781315; c=relaxed/simple;
	bh=n1/U7NOpbu8R8stJtAQuiC2KFN9r0jeNmmKVbQ74/hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNKuLL6dNf5Tq5jw6kBA6sILkd/0/xzjfc/83yCq82GuDwFnNRTyEgmbVT0bbv3au1achuRcEroJWokjLrnZ03EZk/FN1mFSG/vTnAZkusZlspDURmVZYHuLLQvbG1ULsHD/avPASePqgXahkwHPIExoaVABTVeeFkPJ4/yzitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgU/3Cq1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36703b0f914so1392472f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719781313; x=1720386113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ad3QYcJFSLd+8y/rgxwyYNGcFHEbEaHiO6VsLCV36g=;
        b=MgU/3Cq16GfqUn/bJF2crRDuQSRmaa5WHgxYj8qQ2Cj2oQHxRNDKnXOv8WBY5NU0pd
         n9SKfQrip7a29hAXwDgZu5LqXHgR4LLYcCSzLMlMAgDc0ID/RBz6VWw89t1Aok7fgmZ9
         rhnpKzUxfNurNIQkxZhUuUfsd9KgcUul4Y5M38SU9391RA9qUyd454GnGs16lOu6tO6F
         aZBCNmFZkxbwtmpkpolW/hOWCGrTg3bukDwfbNMJpwLLJfGUVZ7JHXUVrSJn7Q07wwjM
         wajSSIGM5u8qIViNrfOS/48WLLwDSLPo5OYccD+Mfmi27fsdJ2R00LvpPzCq+oOkHAI9
         81AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719781313; x=1720386113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ad3QYcJFSLd+8y/rgxwyYNGcFHEbEaHiO6VsLCV36g=;
        b=R9eTEyfLwRg0+zr5fwloINTz1PEbfwr1kib8TiSbjJozsUqKxSQfPQdXsSrWQUAzkV
         uGK7j/ja4FMmwFvvCsw7R9xFrdXE3sbvI8KquFA6ybGUAQ4uV3RrlXutvGkudABSAsEq
         CbD/pfyNG+SmxZJ16W1ujl05Ol1gFuayGVpLmnGwbyGEVicU21AAoLhyGr1I4EO+mlY/
         0vTTeSgMvHdPgIuQ5rpfUCOwnH6cLXTbP1iM3ktRUgEXxhLQVVjBhna7yAV/S8UDBha1
         HxeX1DYlVVVJe+BA81jZeY9aioJEoYkIX1PQQNfk1jj9LobT+a/7XmV66Brb76mfbXho
         ykUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN2/eQuic2okP4buLR0nbxi7CyxApQHcL7CfX5fFA1eYGNyyj+d7S51uk3of/7L1YFRa6WOzlDgdVBQBJUwARv7Po8xQ1pdPPbHXmS
X-Gm-Message-State: AOJu0Yx5+MiMNVs9snXNe6yA2RBPocxiHdG90bZgxHOGWZ7ImUI7eEp1
	eTLTb9NcDh4k0lJr4LsKQqO8J/Vf7b1DfkiJkiy95Zl5+M2ZKc4IB41pWQ==
X-Google-Smtp-Source: AGHT+IHM6OEv+N1ffRskYAzx9Y3hMDvvnePHWY5zmCVx2zgWZMNjHDjjwN8LNyg/WKGi7auM4Qyjng==
X-Received: by 2002:a5d:63d1:0:b0:362:4679:b5a with SMTP id ffacd0b85a97d-36760a7832cmr6005246f8f.16.1719781312505;
        Sun, 30 Jun 2024 14:01:52 -0700 (PDT)
Received: from debian ([67.208.53.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b065316sm122635225e9.26.2024.06.30.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 14:01:52 -0700 (PDT)
Date: Sun, 30 Jun 2024 22:01:50 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: linux@treblig.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org
Subject: Re: [PATCH 2/3] parport: Remove attach function pointer
Message-ID: <ZoHHvuGQBFz0rg4m@debian>
References: <20240502154823.67235-1-linux@treblig.org>
 <20240502154823.67235-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502154823.67235-3-linux@treblig.org>

On Thu, May 02, 2024 at 04:48:22PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The attach function pointers haven't actually been called since:
>   'commit 3275158fa52a ("parport: remove use of devmodel")'
> topped adding entries to the drivers list.
> 
> If you're converting a driver, look at the 'match_port' function
> pointer instead.
> 
> (There are lots of comment references to 'attach' all over, but they
> probably need some deeper understanding to check the semantics
> to see if they can be replaced by match_port).
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

-- 
Regards
Sudip

