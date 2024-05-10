Return-Path: <linux-kernel+bounces-176149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0756D8C2AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B213F1F238F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AD14CE05;
	Fri, 10 May 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKu1207C"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323394AEC1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370377; cv=none; b=Nvos/s1YDSfeN5puZOBetVY9Ng0b4BHvyKM3canZK2Amcq8q/n7FV8AbOKSWYVOuYuZM/cZn1X46EeGUqRl6QGRkQUs9DCIYXn04RCbo7sxp07M32zJvEWcBHPdIfW/D8b4HW1D5DuGjqpHHTiDMa4uo3I8P14o8sz1eZus6UH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370377; c=relaxed/simple;
	bh=g5kYHFJnjQGsLeTWX/w7fQ5Mz/mRyoUbOgayf2lFI9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0bNTE3tiGCbiuruUzoz2HyHL4O2ViMdUrPiHPTwubvqr5zz2drKxXJzPs8SlV1Xyzggq7DXLnuOs6l3qd4+VbppXgna3FmrblNefwEUOGKfKiVI9ct/ocFpzKM20LO1cYoQnfESeX74WSY5uTO0q5GD2LD2HulzWUCfK1pqrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKu1207C; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso3043a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715370374; x=1715975174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5kYHFJnjQGsLeTWX/w7fQ5Mz/mRyoUbOgayf2lFI9I=;
        b=XKu1207CLTpv13BSMASfjIq0j+rPfocvoMqR8wybjCG1jbmu+HfrjldiZhyOWqJ62w
         Bx6URm5ZF2XDauEHQKNOvjaVs8iV81keTJNraBdPFC04NtuvKCnDeQ02Nc13bSOuZGfD
         vuIo8DBJnCxaGY5BAPuMLllkVp28izCBzdKKMzF3qikQR+pE3OH1ZP0UAObwJXkD/iXt
         p8DkJptgfCEt+upZ28T9HDhUvcB7vpZ3Oo+UQldbo/zV/9aSqQDIWyoYEYC37v7kwdZZ
         5KWvPqLOnuf3R7fsu/GMcqM48c3hjGoG5A7OVRf3Qvs9VDje7gcZuedLLhuuh08/8dD6
         aZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715370374; x=1715975174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5kYHFJnjQGsLeTWX/w7fQ5Mz/mRyoUbOgayf2lFI9I=;
        b=XZFqq/TCGfu6aHA9QWYNVKTyksyRX+nRiSLPIhZeuKSh74T/t4jLgL93s1nnn/eIxB
         VyxrucrGM4SB604mJJCZnuZu73H85i/LvAxzh0jXCgF9RfsctlK9ovW7mx5IP9ulzL5b
         NjWc2S1mDBMEGNv49FKA8INn3WhmWeP2dA5G2mCEuey/ItJTNTJOfT/LSRu8zwrvZmz6
         VlkkVrfpy3zIXIINaCmPyQzGb5mceUa19fY9YhEyRgAHgKTFjXnXR2ig4/lBzWTn4TNg
         4S2vdlF2zhojjrOp6HUCSRP6t80mM8St/z5otqTmJUDoROh6xhyIBYzFySlbflqgjYQQ
         nC1w==
X-Forwarded-Encrypted: i=1; AJvYcCVa0O8FhzR/7YE9mO4wHa21kMM7Oy+PQ1crrK7Q21Tcdou8Oz6yHLEECiAKJDNp9ICDu9IEwZfTZh+uxptM+SzHxJqN+6BUs8U1mY55
X-Gm-Message-State: AOJu0YwOPyaLAKTXiw8HfWylCiyAxyqLkklaTrTwlQoHj3/yhluSn4rS
	7Yt0ORCKXRiAhzVoFNTQiNzeQWunkcOY2vxBCzjKJbqmKUf0KzoINgUXMJ9sAVuCLKpn77C11NY
	c+WtJqvAkOtqj6kFmZxluLjgdB2TLiXWs5iu+
X-Google-Smtp-Source: AGHT+IEjkKKgypzFApgZTL0z6ah3x9iM3bgP7Y8Zn5zYPWt30OoG1qkKTUQ+B4bmehmt0GxsYy1tZ9RDpD4OSamQU4Y=
X-Received: by 2002:a05:6402:907:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57443d4d9c7mr27979a12.6.1715370374302; Fri, 10 May 2024
 12:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510184324.2944101-1-jthies@google.com> <20240510184324.2944101-2-jthies@google.com>
In-Reply-To: <20240510184324.2944101-2-jthies@google.com>
From: Jameson Thies <jthies@google.com>
Date: Fri, 10 May 2024 12:46:01 -0700
Message-ID: <CAMFSARcVjCUoGTnNAwy6+RDZ0J6x1hxhVQzdDGOpa0b4cEQJWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] usb: typec: ucsi: Fix null pointer dereference in trace
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hey everyone.
Benson let me know that the submitter should be listed in the last
Signed-off-by line. This is out of order in patch 1/4 and 2/4. My bad,
I'll send out a v5 series fixing this. Sorry about all the email.

Thanks,
Jameson

