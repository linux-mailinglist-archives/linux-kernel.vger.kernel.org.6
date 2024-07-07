Return-Path: <linux-kernel+bounces-243728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868669299A4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64CD2810DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4084F60B96;
	Sun,  7 Jul 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8IyIaW3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6076FA8;
	Sun,  7 Jul 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720382958; cv=none; b=FnxZfF/xECsSJXOiWa9DgJEvNujI+LYygMAAIb1D2vknm6PC5T+n5sD1H1S4TEQHXyFSgyz1B7FGQNcuHcGG7iuJZk2GbNyHcpKDFwlZCjmeMej7Phosm1p2Vwo3/kutsXgKGIpVf+x5OlyQV2OVXm0eYHAJT3sUXQ05XffU8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720382958; c=relaxed/simple;
	bh=deby0RdK1PJBn3kWNlU3vKG44+lDbCBwJ1YUEKYb29o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjDyE2YtOcxDUQGR1hoh9giJf/NVqEUgjZqqd4fE1kIkEjutgqmbRtHvVMF1wB4s6JcDk2qjatVYpDcwdL3Sy3B92PAHqHBVxlLJeLnLnrVv+iTEqnVebnNIF1jLFj/4zNW34FtU/teA0kHEaOTKBpEdgotMTsQkWNXxNAEWAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8IyIaW3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso4394141a12.3;
        Sun, 07 Jul 2024 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720382955; x=1720987755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BlEf2DUil7lwQ7mBYkwtG3dWZjHsv00b/WRtslpkTE=;
        b=B8IyIaW3FKL6sIPlhgDFnZEcqrrHFE6pPVT7430iGI+k5VSBR/shcAH32MSeonr/Tg
         CkcrZJ9QTUibowqspeGLnh/6JOKzMXk+p1QqasrYzAVAvnJOi2SINr/P6zYg8lxQWnEI
         2yFgzKa1fyp2/LU7tiSEC5XmiPQviVPFPFM/IUKFZRQBQl1Ce0qr70wxXbzQolKV1+Yx
         jICjr/0hMJ2wybP2vId8AykA1EP6Akd76/bSLRJuDChvqjGGMY/x8oQ15b9mAkJLf3PN
         nmSqp+LbflePAizs93DAhh+uRCDNx1wRAPTRFu27HSmjmHj1FT8mPfv4aGEg5mW7Gxiz
         udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720382955; x=1720987755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BlEf2DUil7lwQ7mBYkwtG3dWZjHsv00b/WRtslpkTE=;
        b=rOSZe3TlgYeZV3C9l+HQtsYqGE6vXtL96nxA5bpb2zM9bqkIi9u4VTP/7+xS1xsvTD
         8g5nkCnibyDLcADY0zrO1L6JkM2MhHfFTImr50/4/sWqkb952dfRzA81CjhRTVnvd87R
         HLGBrLYko9EAUqhDRZY1gTmjdzqseMjNUypJ/gUeOOpqOfV8pZzy66dUgm1aNT03k8lb
         RY3RGeaZR/2mIUiTnh/Jfp1JNaMZZi9M59dB0vNz+Rem1J6u4yV1+1rLSqNTlThYe0qQ
         HJx5aGBGRrJQ2PF8SWh2faG+xyu/LgtO4rxUgB0xooXpluc+afegrTaHm2ADTzdH5wBN
         IM4g==
X-Forwarded-Encrypted: i=1; AJvYcCX47wbSSWppylE4cjjWdnp8ns2YJl04rDFMtYrP0ahWu4pQFCsMl6Oc7gc8Aw+H7ovUILkbnUeYLcUeH6jA7fk7mChug13KHPbNW96QIi2e0ir2+U60p7Z4F01JVdpzb+Y2nubDFPwH
X-Gm-Message-State: AOJu0YwcSaYWlBmD38fVgNTp7Rf0s5DHDdJIkmLfAxo6ZMOzQf9KYVJG
	K1cZz+0wu9JeoqbL2f97Gno5JRFdoSOMa3YS9IgZKfJApgzLBzXOpSVzCvz838Gl7n7ad8QMHWN
	1v1Ri/rmOcU2H7mpQqovCnnnRdW0=
X-Google-Smtp-Source: AGHT+IEoFbe8L1tXcTvJd3WzLdgGZd18zzfH3EQI/PDKA3xsNbwOn20kUmB37MAuxFjMS7sFoLoTJDFO/Av+w6Wy94Q=
X-Received: by 2002:a05:6402:2803:b0:58e:450b:da08 with SMTP id
 4fb4d7f45d1cf-58e5b4aefdfmr7574085a12.31.1720382954719; Sun, 07 Jul 2024
 13:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706132201.26136-1-sergio.collado@gmail.com> <375dbc3c-e741-4bdb-88ff-35e68d43c36d@gmail.com>
In-Reply-To: <375dbc3c-e741-4bdb-88ff-35e68d43c36d@gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Sun, 7 Jul 2024 22:08:38 +0200
Message-ID: <CAA76j938DZ27g75S0i_hCSC3G2hPiJa2NRiB8+k9UAeuW-geJw@mail.gmail.com>
Subject: Re: [PATCH] docs/sp_SP: Add translation for scheduler/sched-design-CFS.rst
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, 
	Wenyu Huang <huangwenyu5@huawei.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bilbao@vt.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review!

Maybe we could consider updating the original documentation with the
EEVDF scheduler info.

Best regards,
 Sergio.

On Sat, 6 Jul 2024 at 21:00, Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> Hello,
>
> On 7/6/24 08:22, Sergio Gonz=C3=A1lez Collado wrote:
> > Translate Documentation/scheduler/sched-design-CFS.rst into Spanish
> >
> > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> > ---
> >  Documentation/scheduler/sched-design-CFS.rst  |   2 +
> >  Documentation/translations/sp_SP/index.rst    |   1 +
> >  .../translations/sp_SP/scheduler/index.rst    |   8 +
> >  .../sp_SP/scheduler/sched-design-CFS.rst      | 275 ++++++++++++++++++
> >  4 files changed, 286 insertions(+)
> >  create mode 100644 Documentation/translations/sp_SP/scheduler/index.rs=
t
> >  create mode 100644 Documentation/translations/sp_SP/scheduler/sched-de=
sign-CFS.rst
> >
> > diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentati=
on/scheduler/sched-design-CFS.rst
> > index e030876fbd68..bc1e507269c6 100644
> > --- a/Documentation/scheduler/sched-design-CFS.rst
> > +++ b/Documentation/scheduler/sched-design-CFS.rst
> > @@ -1,3 +1,5 @@
> > +.. _sched_design_CFS:
> > +
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  CFS Scheduler
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation=
/translations/sp_SP/index.rst
> > index 274ef4ad96b9..aae7018b0d1a 100644
> > --- a/Documentation/translations/sp_SP/index.rst
> > +++ b/Documentation/translations/sp_SP/index.rst
> > @@ -78,3 +78,4 @@ Traducciones al espa=C3=B1ol
> >
> >     process/index
> >     wrappers/memory-barriers
> > +   scheduler/index
> > diff --git a/Documentation/translations/sp_SP/scheduler/index.rst b/Doc=
umentation/translations/sp_SP/scheduler/index.rst
> > new file mode 100644
> > index 000000000000..768488d6f001
> > --- /dev/null
> > +++ b/Documentation/translations/sp_SP/scheduler/index.rst
> > @@ -0,0 +1,8 @@
> > +.. include:: ../disclaimer-sp.rst
> > +
> > +.. _sp_scheduler_index:
> > +
> > +.. toctree::
> > +    :maxdepth: 1
> > +
> > +    sched-design-CFS
> > diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CF=
S.rst b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
> > new file mode 100644
> > index 000000000000..43e29297d7fa
> > --- /dev/null
> > +++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
> > @@ -0,0 +1,275 @@
> > +.. include:: ../disclaimer-sp.rst
> > +
> > +:Original: :ref:`Documentation/scheduler/sched-design-CFS.rst <sched_d=
esign_CFS>`
> > +:Translator: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> > +
> > +.. _sp_sched_desing_CFS:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Gestor de tareas CFS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +1.  VISI=C3=93N GENERAL
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +CFS viene de las siglas en ingl=C3=A9s de "Gestor te tareas totalmente=
 justo"
>
>
> Change 'te' to 'de'. For the rest of the review, I'll say instead:
> 's/old/new', in this case, s/te/de.
>
>
> > +("Completely Fair Scheduler"), y es el nuevo gestor de tareas de escri=
torio
> > +implementado por Ingo Molnar e integrado en Linux 2.6.23. Es el sustit=
uto de
> > +el previo gestor de tareas SCHED_OTHER.
>
>
> Although I usually don't do this, considering that CFS is no longer the
> most recent scheduler, let's add a note here:
>
> Nota: El planificador EEVDF fue incorporado m=C3=A1s recientemente al ker=
nel.
>
>
> > +
> > +El 80% del dise=C3=B1o de CFS puede ser resumido en una =C3=BAnica fra=
se: CFS
> > +b=C3=A1sicamente modela una "CPU ideal, precisa y multi-tarea" sobre h=
ardware
> > +real.
> > +
> > +"una CPU multitarea ideal" es una CPU (inexistente :-)) que tiene un 1=
00%
> > +de potencia y que puede ejecutar cualquier tarea exactamente a la mism=
a
> > +velocidad, en paralelo, y cada una a 1/n velocidad. Por ejemplo, si ha=
y dos
> > +tareas ejecut=C3=A1ndose, entonces cada una usa un 50% de la potencia =
--- es decir,
> > +como si se ejecutaran en paralelo.
> > +
> > +En un hardware real, se puede ejecutar una =C3=BAnica tarea a la vez, =
as=C3=AD que
>
>
> s/En un hardware/En hardware
>
>
> > +se ha usado el concepto de "tiempo de ejecuci=C3=B3n virtual". El tiem=
po
> > +de ejecuci=C3=B3n virtual de una tarea, espec=C3=ADfica cuando la sigu=
iente porci=C3=B3n
>
>
> s/tarea,/tarea
>
>
> > +de ejecuci=C3=B3n podr=C3=ADa empezar en la CPU ideal multi-tarea desc=
rita anteriormente.
> > +En la pr=C3=A1ctica, el tiempo de ejecuci=C3=B3n virtual de una tarea =
es el
> > +tiempo de ejecuci=C3=B3n real normalizado con respecto al n=C3=BAmero =
total de
> > +tareas ejecut=C3=A1ndose.
> > +
> > +
> > +2.  UNOS CUANTOS DETALLES DE IMPLEMENTACI=C3=93N
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +En CFS, el tiempo de ejecuci=C3=B3n virtual se expresa y se monitoriza=
 por
> > +cada tarea, en su valor de p->se.vruntime (en unidades de nanosegundos=
).
> > +De este modo, es posible temporizar con precisi=C3=B3n y medir el "tie=
mpo
> > +de CPU esperado" que una tarea deber=C3=ADa tener.
> > +
> > +Un peque=C3=B1o detalle: en hardware "ideal", en cualquier momento tod=
as las
> > +tareas pueden tener el mismo valor de p->se.vruntime --- i.e., tareas
> > +se podr=C3=ADan ejecutar simult=C3=A1neamente y ninguna tarea podr=C3=
=ADa escaparse del
> > +"balance" de la partici=C3=B3n "ideal" del tiempo compartido de la CPU=
.
> > +
> > +La l=C3=B3gica de elecci=C3=B3n del tareas de CFS se basa en el valor =
de p->se.vruntime
> > +y por tanto es muy sencilla: siempre intenta ejecutar la tarea con el =
valor
> > +p->se.vruntime m=C3=A1s peque=C3=B1o (i.e., la tarea que se ha ejecuta=
do menos hasta el
> > +momento). CFS siempre intenta dividir el espacio de tiempo entre tarea=
s
> > +en ejecuci=C3=B3n tan pr=C3=B3ximo a la "ejecuci=C3=B3n multitarea ide=
al del hardware" como
> > +sea posible.
> > +
> > +El resto del dise=C3=B1o de CFS simplemente se escapa de este simple c=
oncepto,
> > +con unos cuantos a=C3=B1adidos como los niveles "nice" ("nice" signifi=
ca "amable"
> > +en ingl=C3=A9s), multi-tarea y varias variantes del algoritmo para ide=
ntificar
> > +tareas "durmiendo".
> > +
> > +
> > +3.  EL =C3=81RBOL ROJO-NEGRO
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +El dise=C3=B1o de CFS es bastante radical: no utiliza las antiguas est=
ructuras
> > +de datos para las colas de ejecuci=C3=B3n (en ingl=C3=A9s "runqueues")=
, pero usa una
> > +estructura de =C3=A1rbol rojo-negro (en ingl=C3=A9s "red-black tree") =
ordenado cronol=C3=B3gicamente
> > +para construir un l=C3=ADnea de ejecuci=C3=B3n en el futuro, y por eso=
 no tiene ning=C3=BAn
> > +artificio de "cambio de tareas" (algo que previamente era usado por el=
 gestor
> > +anterior y RSDL/SD).
> > +
> > +CFS tambi=C3=A9n mantiene el valor de rq->cfs.min_vruntime, el cual cr=
ece
> > +monot=C3=B3nicamente siguiendo el valor m=C3=A1s peque=C3=B1o de vrunt=
ime de entre todas
> > +las tareas en la cola de ejecuci=C3=B3n. La cantidad total de trabajo =
realizado
> > +por el sistema es monitorizado usado min_vruntime; este valor es usado
> > +para situar las nuevas tareas en la parte izquierda del =C3=A1rbol tan=
to
> > +como sea posible.
> > +
> > +El valor total de tareas ejecut=C3=A1ndose en la cola de ejecuci=C3=B3=
n es
> > +contabilizado mediante el valor rq->cfs.load, el cual es la suma de lo=
s
> > +de esas tareas que est=C3=A1n en la cola de ejecuci=C3=B3n.
> > +
> > +CFS mantiene un =C3=A1rbol rojo-negro cronol=C3=B3giamente ordenado, d=
onde todas las
>
>
> s/cronol=C3=B3giamente/cronol=C3=B3gicamente
>
>
> > +tareas que pueden ser ejecutadas est=C3=A1n ordenadas por su valor de
> > +p->se.vruntime. CFS selecciona la tarea m=C3=A1s hacia la izquierda de=
 este
> > +=C3=A1rbol y la mantiene. Seg=C3=BAn el sistema contin=C3=BAa, las tar=
eas ejecutadas
> > +se ponen en este =C3=A1rbol m=C3=A1s y m=C3=A1s hacia la derecha --- l=
entamente pero
> > +de forma continuada dando una oportunidad a cada tarea de ser la que
> > +est=C3=A1 "la m=C3=A1s hacia la izquierda" y por tanto obtener la CPU =
una cantidad
> > +determinista de tiempo.
> > +
> > +Resumiendo, CFS funciona as=C3=AD: ejecuta una tarea un tiempo, y cuan=
do la
> > +tarea se gestiona (o sucede un tic del gestor de tareas) se considera
> > +que el tiempo de uso de la CPU se ha completado, y se a=C3=B1ade a
> > +p->se.vruntime. Una vez p->se.vruntime ha aumentado lo suficiente como
> > +para que otra tarea sea "la tarea m=C3=A1s hacia la izquierda" del =C3=
=A1rbol
> > +rojo-negro ordenado cronol=C3=B3gicamente esta mantienen (m=C3=A1s una=
 cierta peque=C3=B1a
> > +cantidad de distancia relativa a la tarea m=C3=A1s hacia la izquierda =
para
> > +que no se sobre-reserven tareas y perjudique a la cache), entonces la
> > +nueva tarea "que est=C3=A1 a la izquierda del todo", es la que se elig=
e
> > +para que se ejecute, y la tarea en ejecuci=C3=B3n es interrumpida.
> > +
> > +4.  ALGUNAS CARACTER=C3=8DSTICAS DE CFS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +CFS usa una granularidad de nanosegundos y no depende de ning=C3=BAn
> > +jiffie o detalles como HZ. De este modo el gestor de tareas CFS no tie=
ne
>
>
> s/modo/modo,
>
>
> > +noci=C3=B3n de "ventanas de tiempo" de la forma en que ten=C3=ADa el g=
estor de
> > +tareas previo, y tampoco tiene heur=C3=ADsticos. =C3=9Anicamente hay u=
n par=C3=A1metro
> > +central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
> > +
> > +   /sys/kernel/debug/sched/base_slice_ns
> > +
> > +El cual puede ser usado para afinar desde el gestor de tareas del "esc=
ritorio"
> > +(i.e., bajas latencias) hacia cargas de "servidor" (i.e., bueno con
> > +procesamientos). Su valor por defecto es adecuado para tareas de escri=
torio.
> > +SCHED_BATCH tambi=C3=A9n es gestionado por el gestor de tareas CFS.
> > +
> > +Debido a su dise=C3=B1o, el gestor de tareas CFS no es proclive a ning=
uno de los
> > +ataques que existen a d=C3=ADa de hoy contra los heur=C3=ADsticos del =
gestor de tareas:
> > +fiftyp.c, thud.c, chew.c, ring-test.c, massive_intr.c todos trabajan
> > +correctamente y no tienen impacto en la interacci=C3=B3n y se comporta=
n de la forma
> > +esperada.
> > +
> > +El gestor de tareas CFS tiene una gesti=C3=B3n mucho m=C3=A1s firme de=
 los niveles
> > +"nice" y SCHED_BATCH que los previos gestores de tareas: ambos tipos d=
e
> > +tareas est=C3=A1n aisladas de forma m=C3=A1s eficiente.
> > +
> > +El balanceo de tareas SMP ha sido rehecho/mejorado: el avance por las
> > +colas de ejecuci=C3=B3n de tareas ha desaparecido del c=C3=B3digo de b=
alanceo de
> > +carga, y ahora se usan iteradores en la gesti=C3=B3n de m=C3=B3dulos. =
El balanceo
> > +del c=C3=B3digo ha sido simplificado como resultado esto.
> > +
> > +5.  Pol=C3=ADticas de gesti=C3=B3n de tareas
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +CFS implementa tres pol=C3=ADticas de gesti=C3=B3n de tareas:
> > +
> > +  - SCHED_NORMAL (tradicionalmente llamada SCHED_OTHER): Gesti=C3=B3n =
de
> > +    tareas que se usan para tareas normales.
> > +
> > +  - SCHED_BATCH: No interrumpe tareas tan amenudo como las tareas
>
>
> s/amenudo/a menudo
>
>
> > +    normales har=C3=ADan, por eso permite a las tareas ejecutarse dura=
nte
> > +    ventanas de tiempo mayores y hace un uso m=C3=A1s efectivo de las
> > +    caches pero al coste de la interactividad. Esto es adecuado
> > +    para trabajos de procesado de datos.
> > +
> > +  - SCHED_IDLE: Esta pol=C3=ADtica es m=C3=A1s d=C3=A9bil incluso que =
nice 19, pero
> > +    no es un gestor "idle" para evitar caer en el problema de la
> > +    inversi=C3=B3n de prioridades que causar=C3=ADa un bloqueo de la m=
=C3=A1quina
> > +    (deadlock).
> > +
> > +SCHED_FIFO/_RR se implementan en sched/rt.c y son espec=C3=ADficos de
> > +POSIX.
> > +
> > +El comando chrt de util-linux-ng 2.13.1.1. puede asignar cualquiera de
> > +estas pol=C3=ADticas excepto SCHED_IDLE.
> > +
> > +
> > +6.  CLASES DE GESTI=C3=93N
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +El nuevo gestor de tareas CFS ha sido dise=C3=B1ado de tal modo para i=
ncluir
> > +"clases de gesti=C3=B3n", una jerarqu=C3=ADa ampliable de m=C3=B3dulos=
 que pueden tener
> > +distintas pol=C3=ADticas de gesti=C3=B3n de tareas. Estos m=C3=B3dulos=
 encapsulan los
> > +detalles de las politicas de gestion y son manejadas por el n=C3=BAcle=
o del
>
>
> s/gestion/gesti=C3=B3n
>
>
> > +gestor de tareas sin que este tenga que presuponer mucho sobre estas c=
lases.
> > +
> > +sched/fair.c implementa el gestor de tareas CFS descrito arriba.
>
>
> s/arriba/antes
>
>
> > +
> > +sched/rt.c implementa la sem=C3=A1ntica de SCHED_FIFO y SCHED_RR, de u=
na forma
> > +m=C3=A1s sencilla que el gestor de tareas anterior. Usa 100 colas de e=
jecuci=C3=B3n
> > +(por todos los 100 niveles de prioridad RT, en vez de las 140 que nece=
sitaba
> > +el gestor de tareas anterior) y no necesita las listas de expiraci=C3=
=B3n.
> > +
> > +Las clases de gesti=C3=B3n de tareas son implementadas por medio de la=
 estructura
> > +sched_class, la cual tiene llamadas a las funciones que deben de llama=
rse
> > +cuando quiera que ocurra un evento interesante.
> > +
> > +Esta es la lista parcial de llamadas:
> > +
> > + - enqueue_task(...)
> > +
> > +   Llamada cuando una tarea entra en el estado de lista para ejecuci=
=C3=B3n.
> > +   Pone la entidad a ser gestionada (la tarea) en el =C3=A1rbol rojo-n=
egro
> > +   e incrementa la variable nr_running.
> > +
> > + - dequeue_task(...)
> > +
> > +   Cuando una tarea deja de ser ejecutable, esta funci=C3=B3n se llama=
 para
> > +   mantener a la entidad gestionada fuera del =C3=A1rbol rojo-negor. E=
sto
> > +   decrementa la variable nr_running.
> > +
> > + - yield_task(...)
> > +
> > +   Esta funci=C3=B3n es b=C3=A1sicamente desencolar, seguido por encol=
ar, a menos que
> > +   sysctl compat_yield est=C3=A9 activado; en ese caso, sit=C3=BAa la =
entidad a gestionar
> > +   en la parte m=C3=A1s hacia la derecha del =C3=A1rbol rojo-negro.
> > +
> > + - check_preempt_curr(...)
> > +
> > +   Esta funci=C3=B3n comprueba si una tarea que ha entrado en el estad=
o de
> > +   poder ser ejecutada, podr=C3=ADa reemplazar a la tarea que actualme=
nte
> > +   se est=C3=A9 ejecutando.
> > +
> > + - pick_next_task(...)
> > +
> > +   Esta funci=C3=B3n elige la tarea m=C3=A1s apropiada para ser ejecut=
ada a continuaci=C3=B3n.
> > +
> > + - set_curr_task(...)
> > +
> > +   Esta funci=C3=B3n se llama cuando una tarea cambia su clase de gest=
i=C3=B3n o
> > +   cambia su grupo de tareas.
> > +
> > + - task_tick(...)
> > +
> > +   Esta funci=C3=B3n es llamada la mayor=C3=ADa de las veces desde la =
funci=C3=B3n de tiempo
> > +   tick; esto puede llevar a un cambio de procesos. Esto dirige el ree=
mplazo
> > +   de las tareas.
> > +
> > +
> > +7.  EXTENSIONES DE GRUPOS PARA CFS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Normalmente, el gestor de tareas gestiona tareas individuales e intent=
a
> > +proporcionar una cantidad justa de CPU a cada tarea. Algunas veces, pu=
ede
> > +ser deseable agrupar las tareas y proporcionarles una cantidad justa
> > +de tiempo de CPU a cada una de las tareas de ese grupo. Por ejemplo,
> > +podr=C3=ADa ser deseable que primero se proporcione una cantidad justa=
 de
> > +tiempo de CPU a cada usuario del sistema y despu=C3=A9s a cada tarea
> > +que pertenezca a un usuario.
> > +
> > +CONFIG_CGROUP_SCHED destaca en conseguir exactamente eso. Permite a la=
s
> > +tareas ser agrupadas y divide el tiempo de CPU de forma just entre eso=
s
> > +grupos.
> > +
> > +CONFIG_RT_GROUP_SCHED permite agrupar tareas de tiempo real (i.e.,
> > +SCHED_FIFO y SCHED_RR).
> > +
> > +CONFIG_FAIR_GROUP_SCHED permite agrupar tareas de CFS (i.e., SCHED_NOR=
MAL y
> > +SCHED_BATCH).
> > +
> > +Estas opciones necesitan CONFIG_CGROUPS para ser definidas, y permitir
> > +al administrador crear grupos arbitrarios de tareas, usando el pseudo
> > +sistema de archivos "cgroup". Vease la documentaci=C3=B3n para m=C3=A1=
s informaci=C3=B3n
> > +sobre este sistema de archivos: Documentation/admin-guide/cgroup-v1/cg=
roups.rst
> > +
> > +Cuando CONFIG_FAIR_GROUP_SCHED es definido, un archivo
> > +"cpu.shares" es creado por cada grupo creado usado en el pseudo
> > +sistema de archivos. V=C3=A9anse por ejemplo los pasos a continuaci=C3=
=B3n
> > +para crear grupos de tareas y modificar cuanto comparten de la CPU
> > +usando el pseudo sistema de archivos "cgroup" ::
> > +
> > +     # mount -t tmpfs cgroup_root /sys/fs/cgroup
> > +     # mkdir /sys/fs/cgroup/cpu
> > +     # mount -t cgroup -ocpu none /sys/fs/cgroup/cpu
> > +     # cd /sys/fs/cgroup/cpu
> > +
> > +     # mkdir multimedia      # crear un grupo de tareas "multimedia"
> > +     # mkdir browser         # crear un grupo de tareas "browser"
> > +
> > +     # #Configurar el grupo multimedia para tener el doble de tiempo d=
e CPU
> > +     # #que el grupo browser
> > +
> > +     # echo 2048 > multimedia/cpu.shares
> > +     # echo 1024 > browser/cpu.shares
> > +
> > +     # firefox &     # Lanzar firefox y moverlo al grupo "browser"
> > +     # echo <firefox_pid> > browser/tasks
> > +
> > +     # #Lanzar gmplayer (o su programa favorito de reproducci=C3=B3n d=
e pel=C3=ADculas)
> > +     # echo <movie_player_pid> > multimedia/tasks
>
>
> Sergio, thank you for contributing to the documentation in Spanish. This =
is
> excellent work! Please, send a v2 with these minor changes, and you can
> add:
> Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> Thanks,
> Carlos
>

