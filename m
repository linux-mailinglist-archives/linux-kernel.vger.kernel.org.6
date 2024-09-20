Return-Path: <linux-kernel+bounces-334661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BBC97DA27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBAFB22201
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EE17DFE8;
	Fri, 20 Sep 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aduHBX+6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00DEBE
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726866111; cv=none; b=rAFvKUBZMhTxhn6G9GJnWCTe+fzoPbD8U7rMfdWXxhKsTtXG2Rd1VYmgIuJkPyXnBRAVhkTn2tH90qtNtLSy0JU2wmcg2oEVkxby64Q2zjDf4gC+fk/XpHRHopr8cAcU4hEVU+CkYJ84sUPmVczHRX/ybF6Hhf034JMRZxmBqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726866111; c=relaxed/simple;
	bh=aW2Nx+9pDAekANQe4nSumsh9tZ2PBvvueH4dM8znLsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5kWdivE6259M5dG0Ws8xzz3hKcyWjGLEoKgJOwtxQQ02nZrImXBQ2hPufKFssd2BtDLQYNBP0qrWPJqjF+iGuYQahIyqVOOEA8F6eZwXGErIh/LcDS3BXtC72P83gEh1QMTau97cqKX9P2Qa327vtXNbpFRWWODpmsteZWW0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aduHBX+6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d3cde1103so297157366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726866108; x=1727470908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdl57amVBu6DXeBOLMK8MN+khwXGaNskcQz0VYuOrAs=;
        b=aduHBX+6QilsvkK+x1fupGYOpETrysa+MJSLQnYdheoEdH+GXbCGPbv395Flo0+82L
         TmkAJdYWauCM70Qk8peQ4XNKaI1Hxu3Qt/9T+586gO82UndiPAxph6eQw9KUH5vsbMkw
         8t/cZNQygXHBrIHanpQTAVbDKeg5BpYO+DJT8EEw4R6X+pwkeeTzA9D+/qkoewxQFgr1
         DaCBZoSjX50CnpnX0t67R+3a3Mgi26kD8DgslwEpdeQ/8451EwlwshGRSWbV8Fx3vAGN
         E9njTcBIfoQmOmz1d5fXPdkgkd4NB7SLJuAFRNK2mMhJVSP6ccUMR3Gl9e87RHbnRx2p
         bkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726866108; x=1727470908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdl57amVBu6DXeBOLMK8MN+khwXGaNskcQz0VYuOrAs=;
        b=Y2+LfdEOMBHZ/ULuVQtuOMD02uysHQWaNzBODWlGxAuMJ15KrlsFE89bzmiLN6AsjG
         H2fb3KT8a2p1CNvItS561lD20WlaCffaqxqO9K6DHDR8ubN56FItFOnmpzlK/+IQZ5BV
         U2bPe65KPicjXbT8KOzQ9tDDKmcBL2JZiEIPlouRyAKZTHaCVVjeSVu8Ua2K58sL3gp8
         1fzEaeCW+wniMAxvw1Zff2hB9ukdibDQQ+GaCWwMf5P6DUG45F3FgO/xLnOODOJIfoJl
         N718EGqoyzhuSKoOp8l+wrgRF58439votrQGWkunevJ/DS2Co293jkRrws9eQQoLKJdj
         HIGA==
X-Forwarded-Encrypted: i=1; AJvYcCU4aXBumPbBocXJI4HQH+D5JMJHgzNpF9EZHI9HUlYL4tY8Is6IfIf/vl90ocFWVrAkuDXi2TjWz0DULb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVey7+tqSeRGLCoGpv/EWLcpE7KOkqTZc6hSFPjNagOWVQ5mPx
	UxMPiTyajXl7ZWXfLzNPq2JRIg2HLL7C6PUaxz0OIQJsnoqFgrlz
X-Google-Smtp-Source: AGHT+IHJCm5WU4OfP6Vr5dJgpvji6/OFtW4ssQU7cAn1A2iDQrIXHtOwwhu3BrwddhGpBXrCEHy0qA==
X-Received: by 2002:a17:907:e22a:b0:a86:8285:24a0 with SMTP id a640c23a62f3a-a90d5658865mr335953566b.23.1726866107766;
        Fri, 20 Sep 2024 14:01:47 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966b6sm905722866b.17.2024.09.20.14.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 14:01:47 -0700 (PDT)
Message-ID: <102418ed-c7c3-3287-7ad0-f7a48b600c18@gmail.com>
Date: Fri, 20 Sep 2024 23:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tools/leds: Add '-h' & '--help' cmd line options to
 uledmon
To: Rajkumar Vadhyar <rajkumarvad@gmail.com>
Cc: "Ricardo B. Marliere" <rbmarliere@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <20240820072341.41153-1-rajkumarvad@gmail.com>
 <20240820072341.41153-2-rajkumarvad@gmail.com>
 <a7ab6f74-08ba-0749-3889-b6d040457ac7@gmail.com>
 <CAPTF_YM5CS5-5sdceU598uY16LaGy1hJMKwVmr75Cqsemjs38g@mail.gmail.com>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <CAPTF_YM5CS5-5sdceU598uY16LaGy1hJMKwVmr75Cqsemjs38g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rajkumar,

LED maintainers are responsible also for tools/leds.
MAINTAINERS file say today the following:

LED SUBSYSTEM
M:  Pavel Machek <pavel@ucw.cz>
M:  Lee Jones <lee@kernel.org>

-- 
Best regards,
Jacek Anaszewski

On 8/26/24 05:58, Rajkumar Vadhyar wrote:
> Hi Jacek,
> Actually when I did getmaintainer.pl <http://getmaintainer.pl> on the 
> patch I was only getting the mailing list email id. Also when I did git 
> blame I saw your name as the committer of the led file so I thought you 
> might be the maintainer also.
> Would you know who is the maintainer of this tools/leds? Thank you
> 
> Regards,
> Rajkumar
> 
> On Sun, 25 Aug 2024, 17:25 Jacek Anaszewski, <jacek.anaszewski@gmail.com 
> <mailto:jacek.anaszewski@gmail.com>> wrote:
> 
>     https://www.royalmail.com/track-your-item#/tracking-results/LE879811818GB
> 
>     You should send it to linux-leds@vger.kernel.org
>     <mailto:linux-leds@vger.kernel.org> and to LEDs maintainer.
> 
>     -- 
>     Best regards,
>     Jacek Anaszewski
> 
>     On 8/20/24 09:23, Rajkumar Vadhyar wrote:
>      > Add '-h' and '--help' command line options to uledmon
>      >
>      > Signed-off-by: Rajkumar Vadhyar <rajkumarvad@gmail.com
>     <mailto:rajkumarvad@gmail.com>>
>      > ---
>      >   tools/leds/uledmon.c | 7 +++++++
>      >   1 file changed, 7 insertions(+)
>      >
>      > diff --git a/tools/leds/uledmon.c b/tools/leds/uledmon.c
>      > index c15a39c1f271..6609235d80b0 100644
>      > --- a/tools/leds/uledmon.c
>      > +++ b/tools/leds/uledmon.c
>      > @@ -11,6 +11,8 @@
>      >    * CTRL+C will exit.
>      >    */
>      >
>      > +#define      ULEDMON_USAGE   "Usage: ./uledmon <device-name>\n"
>      > +
>      >   #include <fcntl.h>
>      >   #include <stdio.h>
>      >   #include <string.h>
>      > @@ -19,6 +21,7 @@
>      >
>      >   #include <linux/uleds.h>
>      >
>      > +
>      >   int main(int argc, char const *argv[])
>      >   {
>      >       struct uleds_user_dev uleds_dev;
>      > @@ -30,6 +33,10 @@ int main(int argc, char const *argv[])
>      >               fprintf(stderr, "Requires <device-name> argument\n");
>      >               return 1;
>      >       }
>      > +     if (!(strcmp(argv[1], "-h")) || !(strcmp(argv[1], "--help"))) {
>      > +             fprintf(stderr, ULEDMON_USAGE);
>      > +             return 1;
>      > +     }
>      >
>      >       strncpy(uleds_dev.name <http://uleds_dev.name>, argv[1],
>     LED_MAX_NAME_SIZE);
>      >       uleds_dev.max_brightness = 100;
> 


