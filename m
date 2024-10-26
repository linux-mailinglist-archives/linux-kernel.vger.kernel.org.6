Return-Path: <linux-kernel+bounces-383392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E39B1B05
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 23:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F148B2157D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 21:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D401D63E6;
	Sat, 26 Oct 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1NvHTZv"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2645217F2C;
	Sat, 26 Oct 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729979592; cv=none; b=m/V8/qL07drcukllnlHbEIvcfTqi2sq/fMiyVDT2fR/MKS8/VafF3qy0zFitfAcEuGt60ho8Mjtk5KdFARm70GVRYykXan5EJ19h57h8GJ3vzWmyjaqWqiMqnFimVgbSl3aMMm8cQgBFHD5kwwhU4QuFo215d9HfYIQ7SE0usfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729979592; c=relaxed/simple;
	bh=XSlUgAMAxDXJaaAjvsdZbgKPDjJUErJfifamLmaUct0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDj8GIaCoFI9yeJDPagoiONY3e4uzseWcJaWiLtei/7qQHhpharfXICu65dev4SaP4jE69gQ2UfsxNL4T8zklya6oV+rfQWuAoTuWyOC94pVNS38CuNv7cZx4FTVO80HtSXZpCfZNMkwqfj6LjIQzaC3dzZ9ogIe4jxhpBJUyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1NvHTZv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fb49c64aso5364802e87.0;
        Sat, 26 Oct 2024 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729979588; x=1730584388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W+nnyTWs91tBu9GfPoYIrTPv/GWn3FNWUtV8E2iTlw=;
        b=C1NvHTZvtQgQWKP2PJkvsIVBkUgQ/IGY8tKoEa2Mk0m4ZyyAKPVkzUFqxmdKuRztRy
         aKJVlxUncFmrrQ+mbnXKOhZ4Y5xMvDVzBST4F29iQc6B285jddGTK+fwzOhs1YzpezfY
         J+CXfskONSvQLctOxOTuGS1rjhb6EIw4wRoh9WY3Q/0TjvXh0y6jpBZ1fRC6B8KrzjD7
         AacDbw+gf3MqNpeyHu72k09kCpLuj4T96Xp0fFHkXXVgPyolO/eosqYjCKolFekn9uOH
         nQI/H44DGPOh+4sWLLL5M+xunCWbXtVEQv+kawu3n7D1gQHr3ZXW0By3eS0ul34c5O0y
         Sc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729979588; x=1730584388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W+nnyTWs91tBu9GfPoYIrTPv/GWn3FNWUtV8E2iTlw=;
        b=Zx0a0j2+Y2BZXkdVkXBpQSNaAsJOmxpotAjdluuVdVMf4Zb3mYwhxM2QS7wMAcQ0FJ
         /dHq9V4vfwacReWGvVIsUxSb2OPk8miwJGXOpDpA6b9QLkxDHuDoXd7xQ4QriL8aolaG
         2c6CRXDL61whTqJvU9ctajhAkBcHxwoKResJEIi0eRLfnPOARcFpe/aq5JrYUy57gi57
         U/6zGyOUXhCRdtE5FIs+GWbE5uhX408K7xb6eHEVPKkUav7iMblBx54/6bcoS7i91e2y
         LhCDp+g0jy2OPMoT+NdQqdHH5O78Vz6diYHWpfT77CfwUQF/5bO8sv/1BFuPv5GpI+iU
         w9GA==
X-Forwarded-Encrypted: i=1; AJvYcCUzv3MPlVYQqWcqdg5zaDzMqNFfrZxxfkk9onS2VuIMGFjlb4ihHchK7qfBHB3bMIsstpB8ASR5FpwCJ4BE@vger.kernel.org, AJvYcCVZ1farUE1PwInZpLINtRpjz2GLroB5b5CUYVmEe4bZKOhG9YxCLuGREMwsEQHCVcYdmfjK8/+pKMz/7aY=@vger.kernel.org, AJvYcCVqC6jwNDA+AoquvvvQQMqoMajXTk3fL5Tke+fatHLjUbOjRp7HFK2/Dmayc4QtloKRy9dVMj5rAEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aC8Cq2icu+JbQf7wvOmWdsvqCjwL2XUVZ/VaeuuPFzzFU18Y
	zIR64w+/fqZUWIBodPuoaoObaqn2AntfWQqF+RvS6g4JRB5YzGwT8wDUiiiFQOC84b2xSczyUdc
	7eA+kmgI67InRyHpwkTPI7AMfjCI=
X-Google-Smtp-Source: AGHT+IHget8ThUfBnpdiGhqf3hSKDqmmAu/jDBCNoS2hdcKAwX8li1rgWRyUyxwoFapyvRsQ90xzMRwmx3usImowzPk=
X-Received: by 2002:a05:6512:3da8:b0:535:6baa:8c5d with SMTP id
 2adb3069b0e04-53b348cbb72mr2397915e87.20.1729979587555; Sat, 26 Oct 2024
 14:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020163706.87123-1-yesanishhere@gmail.com>
 <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com> <CABCoZhDQCYwReG2q9pGNPaLaOxd2OjjQ8j14QgujTFDNmG1Seg@mail.gmail.com>
 <Zxtdm9moPrV4Whp9@opensource.cirrus.com>
In-Reply-To: <Zxtdm9moPrV4Whp9@opensource.cirrus.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Sat, 26 Oct 2024 14:52:55 -0700
Message-ID: <CABCoZhCmUZcPRZHFXjSGxHvDEE3_Bn+a91EehJz5aOeYoCLSsw@mail.gmail.com>
Subject: Re: [PATCH v2] Docs/sound: Update codec-to-codec documentation
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, 
	linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 1:58=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Oct 24, 2024 at 01:27:51PM -0700, anish kumar wrote:
> > On Wed, Oct 23, 2024 at 9:10=E2=80=AFAM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > Bringing the "dummy" into this is quite misleading, that really
> > > relates to DPCM setups. DPCM lets one select any number of back
> > > ends to service a given front end PCM, and often are abused to
> > > achieve things that should really be implemented as C2C links.
> >
> > Aha, understood. For C2C we need a thin dummy codec driver
> > which acts as a cpu driver in the ASoC code right?
> >
>
> No there is no need for any dummies or thins anywhere, a codec to
> codec link is simply a mechanism for hooking two codec drivers
> together.
>
> > Based on the code from bells.c, below is the C2C and we do provide
> > a CPU driver, even though in actual it is a codec driver.
> >
> > SND_SOC_DAILINK_DEFS(wm2200_dsp_codec,
> > DAILINK_COMP_ARRAY(COMP_CPU("wm0010-sdi2")),
> > DAILINK_COMP_ARRAY(COMP_CODEC("wm2200.1-003a", "wm2200")));
> >
>
> Yes you are providing a CPU side to the link, but as you say that
> is actually a CODEC driver. Although I guess really this is really
> more historical accident since links were originally defined between
> CPUs and CODECs.
>
> > Perhaps, I can just remove the "dummy" from the diagram above.
> >
>
> Yeah it has no place in this document.
>
> > > > +single ``cpu_dai`` with both ``codec_dais``. Boot-up logs will
> > > > +display messages similar to:
> > >
> > > That is definitely not what should be happening with a C2C link.
> > > In the system you showed the diagram for above there should be a
> > > connection between the CPU and codec-2, then two separate links
> > > between codec-2 and codecs 1 and 3. No links should be present
> > > between the CPU and codecs 1 or 3.
> >
> > Got it, I will try to convey the same in the diagram but ascii art is h=
ard :)
> >
>
> Apart from the dummy bit the diagram is fine here, it is the
> description in the text that is wrong.
>
> > Can you help clarify my understanding (based on the dapm code walkthrou=
gh),
> > when the mixer control is triggered, the CPU widgets gets triggered
> > thereby triggering codec2 widgets and as there is a static connection
> > between codec1 and codec2 it gets also triggered and the same thing
> > happens to codec3 as it is also linked to codec2?
> >
> > Also, as the widgets are linked to dai ops, all the ops gets triggered =
as well.
> >
>
> DAPM will power up anything that is between an active source and
> an active sync. I would imagine from the diagram shown above
> there would likely be two obvious use-cases:
>
> Host music playback:
> CPU -> CODEC2 -> CODEC3 -> Speaker
>
> When something on the host plays some audio this will inform DAPM
> that the main CPU DAI is now an active source. This will propogate
> through the graph until it finds the speaker sink. The act of
> playing music will power up the CPU -> CODEC2 dailink. Then DAPM
> will power the C2C link between CODEC2 and 3 since it is on the
> audio path.
>
> Cellular call:
> CODEC1 -> CODEC2 -> CODEC3 -> Speaker
>
> In this case the host is not involved at all. The modem is audio
> source and DAPM powers up everything between it and the sink ie.
> the speaker. That would involve the two C2C links between CODEC1
> and 2, and between CODEC2 and 3.

Thanks for the explanation and will add this beauty to the document.
>
> > >
> > > > +
> > > > +.. code-block:: bash
> > > > +
> > > > +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> > > > +   multicodec <-> cpu_dai mapping ok
> > > > +   connected DAI link Dummy-CPU:cpu_dai -> codec-1:dai_1
> > > > +   connected DAI link Dummy-CPU:cpu_dai -> codec-2:dai_2
> > > > +
> > >
> > > Yeah this is definitely mixing in a fair amount of DPCM stuff and
> > > does not match the rest of the description.
> >
> > I guess what you meant is that C2C doesn't care about the above
> > connection as it uses DAPM widget connection to trigger the path
> > right? So, even if this connection doesn't exist C2C will still work.
> >
> > Reason why I am asking is that I saw the above logs when I
> > added a C2C connection.
> >
>
> That I can't really be sure it depends on how your system was put
> together.  There are two things that are reasonably likely:
>
> As I said it is quite likely your system is using Dynamic PCM (DPCM)
> this is a mechanism to attach multiple "Backend End" devices to a
> single "Front End" DAI link. It is often used by systems that have
> a DSP built into the host, which might select different places to
> send the audio to. In many ways this accomplishes the same thing as
> C2C links, such a system could equal well be represented with the
> DSP being a codec driver and each of the "backends" being C2C links.
>
> Alternatively, in the deep dark of history some people did implement
> a "dummy link" from the host to the cellular for the purposes
> of configuring the params on the modem, even though the audio
> technically when through some other route. But this was always a
> hack and we should probably not be detailing it in the documentation.
>

Let me start a new thread on this and start a different thread with relevan=
t
logs and not muddle this documentation with my problem. However,
thanks for this explanation.
> > >
> > > > +To trigger this DAI link, a control interface is established by th=
e
> > > > +DAPM core during internal DAI creation. This interface links to
> > > > +the ``snd_soc_dai_link_event`` function, which is invoked when a
> > > > +path connects in the DAPM core. A mixer must be created to trigger
> > > > +the connection, prompting the DAPM core to evaluate path
> > > > +connections and call the ``snd_soc_dai_link_event`` callback with
> > > > +relevant events.
> > > > +
> > > > +It is important to note that not all operations defined in
> > > > +``snd_soc_dai_ops`` are invoked as codec-to-codec connections offe=
r
> > > > +limited control over DAI configuration. For greater control, a
> > > > +hostless configuration is recommended. The operations typically
> > >
> > > It is not clear to me what a "hostless configuration" is here.
> >
> > What I meant to convey is, if the user wants all pcm ops to get called =
in
> > order then he can use "Hostless FE" and connect to backend use as a nor=
mal PCM.
> >
>
> All the talk of front ends and back ends has nothing to do with
> codec to codec links and should not be relevant for this
> document.

Sure, will get rid of this.
>
> > > > +In a codec-to-codec scenario involving multiple codecs (above
> > > > +bootup logs are for multicodec scenario), it is not feasible to
> > > > +control individual codecs using dummy kcontrols or DAPM widgets.
> > >
> > > I really am not sure what this means. What are we controlling
> > > using dummy kcontrols? Why are we not using the real kcontrols
> > > from the codec to control the codec?
> >
> > Our system includes a DSP that can generate audio(not audio to be
> > honest but can be considered as a audio channel) independently,
> > without CPU involvement. This audio needs to be sent to speakers
> > via codecs, even when playback isn't occurring.
> >
> > We modeled all codecs as a C2C having one single snd_soc_dai_link
> > with multiple codecs. So, now we can control all codecs using mixer
> > control which we created as a part of C2C path completion.
> >
>
> Have you by any chance tried to combine the usual DPCM
> implementation for host side DSPs with a bunch of C2C links? It's
> not necessarily wrong but it seems like an odd choice. Either
> represent the DSP using DPCM or C2C links.
>
> > However, we got a new usecase where we shouldn't turn on all the
> > codecs when mixer control is used for C2C, instead user should be able
> > to specify which codec should get turned on.
> >
> > So, I attempted to add one more dummy mixer as part of C2C mixer
> > path, follishly thinking that if the dummy mixer is not enabled, C2C
> > won't allow the corresponding codec to get turned on. After reading
> > the code, I saw that in C2C implementation it doesn't check for
> > widget power status when turning on the path and nor check if the
> > path is complete or not before calling the pcm ops.
> >
>
> This doesn't seem accurate either, DAPM will only turn on things
> between an active source and an active sink. So it should not be
> enabling links that are not on a complete path. Although that
> said the complete path might be one you didn't intent to exist
> it will take any available route between a source and sink.
> The more typical way to handle this would be to define a
> PIN_SWITCH for the sink on each CODEC then you can enable/disable
> those sinks and the CODECs in question should not get powered up
> if they have no valid sinks.
>
> Thanks,
> Charles

